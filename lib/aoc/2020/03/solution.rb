# frozen_string_literal: true

require 'aoc/auto_test'
module Aoc
  module Y2020
    class D03
      include Aoc::AutoTest[example: [7, 336], input: [195, 3_772_314_000]]

      def initialize(data)
        @data = data.lines.map(&:strip)
        @width = @data.first.size
      end

      def part_one(rgt = 3, dwn = 1)
        @data
          .each_slice(dwn)
          .map
          .with_index { |line, index| line.first[(index * rgt) % @width] }
          .drop(1)
          .count('#')
      end

      def part_two
        [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
          .map { part_one(*_1) }
          .reduce(&:*)
      end
    end
  end
end
