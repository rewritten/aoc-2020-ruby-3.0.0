# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D08
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 1371
      solution part_two: 2117

      def initialize(data)
        @data = data
      end

      def part_one
        @data.lines.map(&:chomp).sum { _1.size - eval(_1).size }
      end

      def part_two
        @data.lines.map(&:chomp).sum { _1.inspect.size - _1.size }
      end
    end
  end
end
