# frozen_string_literal: true

# Passport
class Passport
  FIELDS = %w[byr iyr eyr hgt hcl ecl pid].freeze

  def initialize(data)
    @info = Hash[data.strip.split.map { _1.split(':', 2) }]
  end

  def keys = Set.new(@info.keys)

  def to_h = @info

  def all_fields_present? = FIELDS.all? { @info.key? _1 }

  def valid? = all_fields_present? && FIELDS.all? { |k| send("valid_#{k}?") }

  private

  def valid_byr? = @info['byr'].to_i.then { _1 >= 1920 && _1 <= 2002 }

  def valid_iyr? = @info['iyr'].to_i.then { _1 >= 2010 && _1 <= 2020 }

  def valid_eyr? = @info['eyr'].to_i.then { _1 >= 2020 && _1 <= 2030 }

  def valid_hgt?
    case /^(\d+)(in|cm)$/.match(@info['hgt'])&.captures
    in [amt, 'in']
      amt.to_i.then { _1 >= 59 && _1 <= 76 }
    in [amt, 'cm']
      amt.to_i.then { _1 >= 150 && _1 <= 193 }
    in _
      false
    end
  end

  def valid_hcl? = /^#\h{6}$/.match?(@info['hcl'])

  def valid_ecl? = %w[amb blu brn gry grn hzl oth].include?(@info['ecl'])

  def valid_pid? = /^\d{9}$/.match?(@info['pid'])
end
