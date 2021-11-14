# frozen_string_literal: true

require 'aoc/auto_test'
require 'set'

module Aoc
  module Y2020
    class D24
      include Aoc::AutoTest

      solution part_one: 420
      solution part_two: 4206

      def initialize(data)
        @data = data
      end

      DIRS = {
        'e' => [2, 0],
        'ne' => [1, 1],
        'se' => [1, -1],
        'w' => [-2, 0],
        'nw' => [-1, 1],
        'sw' => [-1, -1]
      }.freeze

      def part_one
        @blacks = Set.new

        @data.each_line do |line|
          tile = line.chomp.split(/(?<=[ew])/).reduce([0, 0]) { _1.zip(DIRS[_2]).map(&:sum) }

          @blacks.delete(tile) unless @blacks.add?(tile)
        end

        @blacks.size
      end

      def part_two
        part_one

        100.times { proceed }

        @blacks.size
      end

      private

      def proceed
        @blacks
          .flat_map { [[_1 + 2, _2], [_1 + 1, _2 + 1], [_1 - 1, _2 + 1], [_1 - 2, _2], [_1 + 1, _2 - 1], [_1 - 1, _2 - 1]] } # rubocop:disable Layout/LineLength
          .tally
          .tap { |neighbors| @blacks.keep_if { neighbors[_1] == 1 || neighbors[_1] == 2 } }
          .each { @blacks.add _1 if _2 == 2 }
      end
    end
  end
end
