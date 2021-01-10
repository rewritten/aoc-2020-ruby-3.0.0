# frozen_string_literal: true

require 'aoc/auto_test'
module Aoc
  module Y2020
    class D06
      include Aoc::AutoTest

      solution part_one: 6457
      solution part_two: 3260

      def initialize(data)
        @data = data.split("\n\n")
      end

      def part_one
        @data.map { (_1.chars & [*'a'..'z']).count }.sum
      end

      def part_two
        @data.map { _1.lines.map(&:chars).reduce([*'a'..'z'], &:&).count }.sum
      end
    end
  end
end
