# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2016
    class D03
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 983
      solution part_two: 1836

      def initialize(data)
        @data = data
      end

      def part_one
        @data
          .lines
          .map { |line| line.scan(/\d+/).map(&:to_i) }
          .count { pythagorean? _1 }
      end

      def part_two
        @data
          .lines
          .map { |line| line.scan(/\d+/).map(&:to_i) }
          .each_slice(3)
          .map(&:transpose)
          .flatten(1)
          .count { pythagorean? _1 }
      end

      private

      def pythagorean?(numbers)
        a, b, c = numbers.sort
        a + b > c
      end
    end
  end
end
