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
        @cache = Hash.new { |h, k| h[k] = Set.new }
        @occupied = Set.new

        data.each_line.with_index do |line, y|
          line.each_char.with_index do |char, x|
            @seats << [x, y] if char == 'L'
          end
        end
      end

      def part_one
        populate_by { |(a, b), (c, d)| (a - c).abs <= 1 && (b - d).abs <= 1 }
        loop until board_ferry(3)
        @occupied.size
      end

      def part_two
        populate_by { true }
        loop until board_ferry(4)
        @occupied.size
      end

      private

      def board_ferry(max_nearby_occupation)
        to_be_occupied = @seats.select { |seat| @cache[seat].count { @seats.include? _1 } <= max_nearby_occupation }

        to_be_occupied.each do |seat|
          @seats.subtract(@cache[seat])
          @occupied.add(seat)
          @seats.delete(seat)
        end.empty?
      end

      def populate_by
        [:first, :last, :sum, -> { _1.reduce(&:-) }]
          .map { @seats.group_by(&_1) }
          .reduce(&:chain)
          .each do |_, row|
            row.sort.each_cons(2) do |x, y|
              next unless yield x, y

              @cache[x].add(y)
              @cache[y].add(x)
            end
          end
      end
    end
  end
end
