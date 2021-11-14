# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2016
    class D06
      include Aoc::AutoTest

      solution part_one: 'xhnqpqql'
      solution part_two: 'brhailro'

      def initialize(data)
        @data = data
      end

      def part_one
        @data
          .lines
          .map { _1.chomp.chars }
          .transpose
          .map { _1.tally.invert.max.last }
          .join
      end

      def part_two
        @data
          .lines
          .map { _1.chomp.chars }
          .transpose
          .map { _1.tally.invert.min.last }
          .join
      end
    end
  end
end
