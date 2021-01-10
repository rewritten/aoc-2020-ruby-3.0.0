# frozen_string_literal: true

require 'aoc/auto_test'
module Aoc
  module Y2020
    class D04
      include Aoc::AutoTest

      solution part_one: 196
      solution part_two: 114

      def initialize(data)
        @data = data.split("\n\n")
      end

      RE_BASE = /
        \A(?:
          pid:(?<pid>\S+)(?:\s+|\z) |
          byr:(?<byr>\S+)(?:\s+|\z) |
          eyr:(?<eyr>\S+)(?:\s+|\z) |
          iyr:(?<iyr>\S+)(?:\s+|\z) |
          hgt:(?<hgt>\S+)(?:\s+|\z) |
          hcl:(?<hcl>\S+)(?:\s+|\z) |
          ecl:(?<ecl>\S+)(?:\s+|\z) |
          cid:\S+(?:\s+|\z)
        )+\z
      /mx

      RE_VALID = /
        \A(?:
          pid:(?<pid>\d{9})(?:\s+|\z) |
          byr:(?<byr>#{[*1920..2002].join('|')})(?:\s+|\z) |
          eyr:(?<eyr>#{[*2020..2030].join('|')})(?:\s+|\z) |
          iyr:(?<iyr>#{[*2010..2020].join('|')})(?:\s+|\z) |
          hgt:(?<hgt>(?:(?:#{[*59..76].join('|')})in|(?:#{[*150..193].join('|')})cm))(?:\s+|\z) |
          hcl:(?<hcl>\#\h{6})(?:\s+|\z) |
          ecl:(?<ecl>amb|blu|brn|gry|grn|hzl|oth)(?:\s+|\z) |
          cid:\S+(?:\s+|\z)
        )+\z
      /mx

      def part_one
        @data
          .grep(RE_BASE) { Regexp.last_match.named_captures }
          .count { _1.each_value.none?(&:nil?) }
      end

      def part_two
        @data
          .grep(RE_VALID) { Regexp.last_match.named_captures }
          .count { _1.each_value.none?(&:nil?) }
      end
    end
  end
end
