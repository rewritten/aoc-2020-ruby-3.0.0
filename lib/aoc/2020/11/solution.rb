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

      solution part_one: 2108
      solution part_two: 1897

      def initialize(data)
        @seats = Set.new

        data.lines.each_with_index do |line, y|
          line.chars.each_with_index do |char, x|
            @seats << [x, y] if char == 'L'
          end
        end

        @max_x = data.lines.first.strip.size
        @max_y = data.lines.size
      end

      def part_one
        @cache = populate_by(@seats, &TOUCH)
        board_ferry(3)
      end

      def part_two
        @cache = populate_by(@seats, &SIGHT)
        board_ferry(4)
      end

      private

      def board_ferry(max_nearby_occupation)
        available = Set.new(@seats)
        occupied = Set.new

        loop do
          incl = available.method(:include?)
          to_be_occupied = available.select { (@cache[_1]).count(&incl) <= max_nearby_occupation }

          occupied += to_be_occupied

          return occupied.size if to_be_occupied.empty?

          to_be_kept_free = available.select { |seat| @cache[seat].intersect? occupied }

          available -= to_be_kept_free
          available -= to_be_occupied
        end
      end

      ROW_FUNS = [:first.to_proc, :last.to_proc, :sum.to_proc, -> { _1.reduce(&:-) }].freeze
      SIGHT = proc { true }
      TOUCH = proc { |(a, b), (c, d)| (a - c).abs <= 1 && (b - d).abs <= 1  }

      def populate_by(seats)
        ROW_FUNS.each_with_object(Hash.new { |h, k| h[k] = Set.new }) do |fun, cache|
          seats.group_by(&fun).each_value do |row|
            row.sort.each_cons(2) do |x, y|
              next unless yield x, y

              cache[x].add(y)
              cache[y].add(x)
            end
          end
        end
      end

      # bench :initialize
      # bench :populate_by
      # bench :board_ferry

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
