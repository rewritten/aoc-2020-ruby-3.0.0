# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2019
    class D04
      include Aoc::AutoTest

      # example part_one: 1234,
      #         part_two: 2345,
      #         data: '...'

      solution part_one: 1625
      solution part_two: 1111

      def initialize(data)
        @data = data
        @min, @max = @data.split('-').map { _1.to_i.digits.reverse }
        (0..4).each do |i|
          if @min[i] > @min[i + 1]
            @min = @min[..i] + [@min[i]] * (5 - i)
            break
          end
        end
      end

      def part_one
        passwords_enumerator.count { _1 in [*, a, ^a, *] }
      end

      def part_two
        passwords_enumerator.count do
          case _1
          in [*, _a, ^_a, ^_a, ^_a, ^_a, *]
            false
          in [_a, ^_a, _b, ^_b, _c, ^_c]
            true
          in [*, _a, ^_a, ^_a, ^_a, *] | [_a, ^_a, ^_a, _b, ^_b, ^_b]
            false
          in [*, _a, ^_a, _b, ^_b, ^_b, *] | [*, _a, ^_a, ^_a, _b, ^_b, *] |
             [_a, ^_a, _, _b, ^_b, ^_b] | [_a, ^_a, ^_a, _, _b, ^_b]
            true
          in [*, _a, ^_a, ^_a, *]
            false
          in [*, _a, ^_a, *]
            true
          else
            false
          end
        end
      end

      private

      def passwords_enumerator
        Enumerator.new do |y|
          current = @min
          loop do
            break if (current <=> @max) == 1

            y << current

            current = case current
              in [9, 9, 9, 9, 9, 9]
                break
              in [a, 9, 9, 9, 9, 9]
                [a + 1, a + 1, a + 1, a + 1, a + 1, a + 1]
              in [b, a, 9, 9, 9, 9]
                [b, a + 1, a + 1, a + 1, a + 1, a + 1]
              in [c, b, a, 9, 9, 9]
                [c, b, a + 1, a + 1, a + 1, a + 1]
              in [d, c, b, a, 9, 9]
                [d, c, b, a + 1, a + 1, a + 1]
              in [e, d, c, b, a, 9]
                [e, d, c, b, a + 1, a + 1]
              in [f, e, d, c, b, a]
                [f, e, d, c, b, a + 1]
            end
          end
        end
      end
    end
  end
end
