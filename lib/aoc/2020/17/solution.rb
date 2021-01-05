# frozen_string_literal: true

require 'aoc/auto_test'
require 'set'

module Aoc
  module Y2020
    class D17
      include Aoc::AutoTest

      example part_one: 112, part_two: 848, data: <<~TEXT
        .#.
        ..#
        ###
      TEXT

      solution part_one: 324
      solution part_two: 1836

      def initialize(data)
        @data = Set.new
        @cache = {}
        data.lines.each_with_index do |line, y|
          line.chars.each_with_index do |ch, x|
            @data << [x, y] if ch == '#'
          end
        end
      end

      def part_one
        board = Set.new(@data) { [_1, _2, 0] }

        6.times { cycle(board) { neighbors_3d _1 } }

        board.count
      end

      def part_two
        board = Set.new(@data) { [_1, _2, 0, 0] }

        6.times { cycle(board) { neighbors_4d _1 } }

        board.count
      end

      def self.make_neighbors(dimensions)
        return [[]] if dimensions.zero?

        make_neighbors(dimensions - 1).flat_map { [[-1, *_1], [0, *_1], [1, *_1]] }
      end

      NEIGHBORS_3D = (make_neighbors(3) - [[0, 0, 0]]).freeze
      NEIGHBORS_4D = (make_neighbors(4) - [[0, 0, 0, 0]]).freeze

      private

      def cycle(board)
        nbcount = board.flat_map { yield _1 }.tally.select { |_, v| [2, 3].include?(v) }
        board.keep_if { nbcount.key?(_1) }
        to_spawn = nbcount.select { _2 == 3 && !board.include?(_1) }.keys
        board.merge to_spawn
      end

      def neighbors_3d(coord)
        coord => [x, y, z]
        NEIGHBORS_3D.map { [x + _1, y + _2, z + _3] }
      end

      def neighbors_4d(coord)
        coord => [x, y, z, w]
        NEIGHBORS_4D.map { [x + _1, y + _2, z + _3, w + _4] }
      end
    end
  end
end
