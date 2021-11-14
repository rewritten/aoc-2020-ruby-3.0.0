# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2016
    class D01
      include Aoc::AutoTest

      solution part_one: 181
      solution part_two: 140

      def initialize(data)
        @data = data.scan(/(L|R)(\d+)/)
      end

      def part_one
        pos = 0
        dir = 1

        @data.each do |turn, dist|
          dir *= turn == 'R' ? 1i : -1i
          pos += dir * dist.to_i
        end

        pos.real.abs + pos.imaginary.abs
      end

      def part_two
        pos = 0
        dir = 1

        visited = Set.new

        @data.each do |turn, dist|
          dir *= turn == 'R' ? 1i : -1i
          dist.to_i.times do
            pos += dir
            return pos.real.abs + pos.imaginary.abs unless visited.add?(pos)
          end
        end
      end
    end
  end
end
