# frozen_string_literal: true

require 'set'
require 'aoc/auto_test'

module Aoc
  module Y2020
    class D11
      include Aoc::AutoTest

      example part_one: 37, part_two: 26, data: <<~TXT
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
      TXT

      solution part_one: 2108,
               part_two: 1897

      def initialize(data)
        @seats = Set.new

        data.lines.each_with_index do |line, y|
          line.chars.each_with_index do |char, x|
            @seats << [x, y] if char == 'L'
          end
        end

        @max_x = data.lines.first.strip.size
        @max_y = data.lines.size

        @visible_neighbours_cache = populate_by_sight(@seats)
        @neighbours_cache = populate_by_touch(@seats)
      end

      def part_one
        board_ferry(
          occupy: ->(seat, available) { neighbors(seat).count { available.include? _1 } < 4 },
          keep_free: ->(seat, occupied) { neighbors(seat).any? { occupied.include? _1 } }
        )
      end

      def part_two
        board_ferry(
          occupy: ->(seat, available) { visible_neighbours(seat).count { available.include? _1 } < 5 },
          keep_free: ->(seat, occupied) { visible_neighbours(seat).any? { occupied.include? _1 } }
        )
      end

      private

      DIRECTIONS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

      def board_ferry(occupy:, keep_free:)
        available = Set.new(@seats)
        occupied = Set.new

        loop do
          to_be_occupied = available.select { |seat| occupy.call(seat, available) }

          occupied += to_be_occupied

          return occupied.size if to_be_occupied.empty?

          to_be_kept_free = available.select { |seat| keep_free.call(seat, occupied) }

          available -= to_be_kept_free
          available -= to_be_occupied
        end
      end

      def populate_by_sight(seats)
        Hash[seats.map do |seat|
          [seat, DIRECTIONS.map do |direction|
            (1..).lazy
                 .map { |d| move(seat, direction, d) }
                 .take_while { in_bounds? _1 }
                 .find { seats.include? _1 }
          end.compact]
        end]
      end

      def populate_by_touch(seats)
        Hash[seats.map do |seat|
          [seat, DIRECTIONS.map do |direction|
            (1..).lazy
                 .map { |d| move(seat, direction, d) }
                 .take(1)
                 .find { seats.include? _1 }
          end.compact]
        end]
      end

      def move(from, dir, distance)
        from => [x, y]
        dir =>  [dx, dy]
        [x + distance * dx, y + distance * dy]
      end

      def in_bounds?(position)
        position => [nx, ny]
        nx >= 0 && nx <= @max_x && ny >= 0 && ny <= @max_y
      end

      def will_occupy(seats, seat)
        neighbors(seat).count { seats.include? _1 } < 4
      end

      def will_keep_free(occupied, seat)
        neighbors(seat).any? { occupied.include? _1 }
      end

      def neighbors(seat)
        @neighbours_cache[seat]
      end

      def visible_neighbours(seat)
        @visible_neighbours_cache[seat]
      end
    end
  end
end
