# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D18
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 768
      solution part_two: 781

      def initialize(data)
        @data = data.lines.map { |r| [false, *r.chomp.chars.map { _1 == '#' }, false] }
        @data = [[false] * 102, *@data, [false] * 102]
        @next = @data.map(&:dup)
      end

      def part_one
        100.times { step }
        @data.flatten.count(true)
      end

      def part_two
        100.times do
          step
          turn_on_again
        end
        @data.flatten.count(true)
      end

      private

      def turn_on_again
        @data[1][100] = @data[100][100] = @data[100][1] = @data[1][1] = true
      end

      def step
        1.upto(100) do |y|
          1.upto(100) do |x|
            neighbors = [
              @data[x - 1][y - 1], @data[x][y - 1], @data[x + 1][y - 1], @data[x - 1][y],
              @data[x + 1][y], @data[x - 1][y + 1], @data[x][y + 1], @data[x + 1][y + 1]
            ]

            @next[x][y] = @data[x][y] ? neighbors.count(true).between?(2, 3) : neighbors.count(true) == 3
          end
        end
        @data, @next = @next, @data
      end
    end
  end
end
