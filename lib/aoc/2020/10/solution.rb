# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D10
      include Aoc::AutoTest

      example part_one: 35, part_two: 8, data: '16 10 15 5 1 11 7 19 6 12 4'

      solution part_one: 2400,
               part_two: 338_510_590_509_056

      def initialize(data)
        @data = data.split.map(&:to_i).sort
        @data = [0, *@data, @data.last + 3]
      end

      def part_one
        @data.each_cons(2).map { _2 - _1 }.tally.values_at(1, 3).then { _1 * _2 }
      end

      def part_two
        @data
          .each_cons(2)
          .slice_after { _1 + 3 == _2 }
          .reject { _1.size < 3 }
          .map { _1.map(&:first) }
          .map { count_arrangements(_1) }
          .reduce(&:*)
      end

      private

      def count_arrangements(numbers)
        numbers => [low, *rest, high]

        (0..rest.size).sum do |sz|
          rest.combination(sz).count do |comb|
            [low, *comb, high].each_cons(2).all? { _2 - _1 <= 3 }
          end
        end
      end
    end
  end
end
