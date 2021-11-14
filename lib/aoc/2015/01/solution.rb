# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D01
      include Aoc::AutoTest

      solution part_one: 232
      solution part_two: 1783

      def initialize(data)
        @data = data
      end

      def part_one
        @data.count('(') - @data.count(')')
      end

      def part_two
        floor = 0
        @data.chars.each_with_index do |c, i|
          floor += 1 if c == '('
          floor -= 1 if c == ')'
          return i + 1 if floor == -1
        end
      end
    end
  end
end
