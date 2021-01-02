# frozen_string_literal: true

require 'aoc/auto_test'
module Aoc
  module Y2020
    class D04
      include Aoc::AutoTest[example: [2, 2], input: [196, 114]]

      def initialize(data)
        @data = data.split("\n\n").map do |info|
          Hash[info.strip.split.map { _1.split(':', 2) }].transform_keys(&:to_sym)
        end
      end

      def part_one
        @data.count { _1 in {byr: _, iyr: _, eyr: _, hgt: _, hcl: _, ecl: _, pid: _} }
      end

      def part_two
        @data.count do
          (_1 in {
            pid: /^\d{9}$/, byr: /^\d{4}$/, eyr: /^\d{4}$/, iyr: /^\d{4}$/,
            hgt: /^\d+(in|cm)$/, hcl: /^#\h{6}$/, ecl: 'amb'|'blu'|'brn'|'gry'|'grn'|'hzl'|'oth'
          }) &&
            (_1[:byr].to_i in 1920..2002) &&
            (_1[:iyr].to_i in 2010..2020) &&
            (_1[:eyr].to_i in 2020..2030) &&
            (_1[:hgt].split(/(?<=\d)(?=\D)/).then { |qty, u| [qty.to_i, u] } in [150..193, 'cm'] | [59..76, 'in'])
        end
      end
    end
  end
end
