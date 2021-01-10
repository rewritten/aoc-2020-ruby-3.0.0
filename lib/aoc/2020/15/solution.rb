# frozen_string_literal: true

require 'aoc/auto_test'
require 'set'

module Aoc
  module Y2020
    class D15
      include Aoc::AutoTest

      solution part_one: 371
      solution part_two: 352

      def initialize(data)
        @data = data.split(',').map(&:to_i)
        @storage = []
      end

      def part_one = play(2020)

      def part_two = play(30_000_000)

      def play(turns)
        next_to_say = 0

        @data.each_with_index { |elm, idx| @storage[elm] = idx }

        (@data.size...turns - 1).each do |turn|
          p = @storage[next_to_say] || turn
          @storage[next_to_say] = turn
          next_to_say = turn - p
        end

        next_to_say
      end
    end
  end
end
