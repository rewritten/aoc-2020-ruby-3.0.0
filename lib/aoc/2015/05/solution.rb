# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D05
      include Aoc::AutoTest

      # example part_one: 1, data: 'ugknbfddgicrmopn'
      # example part_one: 1, data: 'aaa'
      # example part_one: 0, data: 'jchzalrnumimnmhp'
      # example part_one: 0, data: 'haegwjzuvuyypxyu'
      # example part_one: 0, data: 'dvszwmarrgswjxmb'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 258
      solution part_two: 53

      def initialize(data)
        @data = data.lines.map(&:chomp)
      end

      def part_one
        @data.count { _1.match?(/[aeiou].*[aeiou].*[aeiou]/) && _1.match?(/(.)\1/) && !_1.match?(/ab|cd|pq|xy/) }
      end

      def part_two
        @data.count { _1.match?(/(..).*\1/) && _1.match?(/(.).\1/) }
      end
    end
  end
end
