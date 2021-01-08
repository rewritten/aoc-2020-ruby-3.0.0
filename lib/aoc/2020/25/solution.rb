# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D25
      include Aoc::AutoTest

      solution part_one: 18_608_573

      def initialize(data)
        @data = data.scan(/\d+/).map(&:to_i)
      end

      def part_one
        left, right = @data

        a = b = 1
        loop do
          a = a * 7 % 20_201_227
          b = b * right % 20_201_227
          break b if a == left
        end
      end
    end
  end
end
