# frozen_string_literal: true

class Solution
  def initialize(data)
    @data = data.split("\n\n").map { |info| Hash[info.strip.split.map { _1.split(':', 2) }].transform_keys(&:to_sym) }
  end

  def part_one
    @data.count { all_fields_present? _1 }
  end

  def part_two
    @data.count { valid? _1 }
  end

  private

  def all_fields_present?(passport) = (passport in {byr: _, iyr: _, eyr: _, hgt: _, hcl: _, ecl: _, pid: _})

  def valid?(passport)
    valid_format?(passport) &&
      (passport[:byr].to_i in 1920..2002) &&
      (passport[:iyr].to_i in 2010..2020) &&
      (passport[:eyr].to_i in 2020..2030) &&
      (passport[:hgt].split(/(?<=\d)(?=\D)/).then { |qty, unit| [qty.to_i, unit] } in [150..193, 'cm'] | [59..76, 'in'])
  end

  def valid_format?(passport)
    passport in {
      byr: /^\d{4}$/,
      ecl: 'amb'|'blu'|'brn'|'gry'|'grn'|'hzl'|'oth',
      eyr: /^\d{4}$/,
      hcl: /^#\h{6}$/,
      hgt: /^\d+(in|cm)$/,
      iyr: /^\d{4}$/,
      pid: /^\d{9}$/
    }
  end
end
