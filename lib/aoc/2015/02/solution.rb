# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D02
      include Aoc::AutoTest

      solution part_one: 1_586_300
      solution part_two: 3_737_498

      def initialize(data)
        @data = data
      end

      def part_one
        @data.lines
             .map { _1.scan(/\d+/).map(&:to_i).sort }
             .map { |x, y, z| 3 * x * y + 2 * x * z + 2 * y * z }
             .sum
      end

      def part_two
        @data.lines
             .map { _1.scan(/\d+/).map(&:to_i).sort }
             .map { |x, y, z| 2 * (x + y) + x * y * z }
             .sum
      end
    end
  end
end
