# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2019
    class D01
      include Aoc::AutoTest

      solution part_one: 3_266_288
      solution part_two: 4_896_582

      def initialize(data)
        @data = data.lines.map(&:to_i)
      end

      def part_one
        @data.sum { fuel(_1) }
      end

      def part_two
        @data.sum { fuel_rec(_1) }
      end

      private

      def fuel(mass) = (mass / 3 - 2).clamp(0..)

      def fuel_rec(mass)
        case fuel(mass)
          in 0 then 0
          in other then other + fuel_rec(other)
        end
      end
    end
  end
end
