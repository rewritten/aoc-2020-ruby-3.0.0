# frozen_string_literal: true

require 'aoc/auto_test'
module Aoc
  module Y2020
    class D06
      include Aoc::AutoTest

      example part_one: 11, part_two: 6, data: <<~TXT
        abc

        a
        b
        c

        ab
        ac

        a
        a
        a
        a

        b
      TXT

      solution part_one: 6457,
               part_two: 3260

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
