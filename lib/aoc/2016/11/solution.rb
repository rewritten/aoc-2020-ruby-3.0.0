# frozen_string_literal: true

require 'aoc/auto_test'
require 'aoc/a_star'

module Aoc
  module Y2016
    class D11
      include Aoc::AutoTest

      solution part_one: 33
      solution part_two: 57

      def initialize(data)
        @data = data
      end

      def part_one
        start = [1, [[1, 1], [2, 3], [2, 3], [2, 3], [2, 3]]]
        goal = [4, [[4, 4], [4, 4], [4, 4], [4, 4], [4, 4]]]
        path = AStar.new.path(start, goal) { next_positions _1 }
        path.size - 1
      end

      def part_two
        start = [1, [[1, 1], [1, 1], [1, 1], [2, 3], [2, 3], [2, 3], [2, 3]]]
        goal = [4, [[4, 4], [4, 4], [4, 4], [4, 4], [4, 4], [4, 4], [4, 4]]]
        path = AStar.new.path(start, goal) { next_positions _1 }
        path.size - 1
      end

      private

      def next_positions(pos)
        cur_elev, item_floors = pos
        item_floors = item_floors.flatten
        indices = item_floors.each_index.filter { |i| item_floors[i] == cur_elev }

        # list the possible choices to move objects (sets of 1 or 2 objects at my floor)
        choices = (indices.combination(2) + indices.combination(1)).to_a

        # list the floors I can get to (it can be one or two floors)
        floors = case cur_elev
                 when 1 then [2]
                 when 2 then [1, 3]
                 when 3 then [2, 4]
                 when 4 then [3]
                 end

        choices.product(floors).map do |choice, new_floor|
          new_floors = item_floors.dup
          choice.each { |i| new_floors[i] = new_floor }
          new_floors = new_floors.each_slice(2).to_a
          [new_floor, new_floors.sort] if new_floors.all? { |g, m| g == m || new_floors.none? { |j| j[0] == m } }
        end.compact.uniq
      end
    end
  end
end
