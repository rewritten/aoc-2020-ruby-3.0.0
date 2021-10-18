# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D03
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 2565
      solution part_two: 2639

      def initialize(data)
        @data = data
      end

      def part_one
        pos = [0, 0]
        map = { pos.to_s => true }
        @data.chars.each do |char|
          case char
          when '^' then pos[1] += 1
          when 'v' then pos[1] -= 1
          when '>' then pos[0] += 1
          when '<' then pos[0] -= 1
          end
          map[pos.to_s] = true
        end
        map.count
      end

      def part_two
        positions = [[0, 0], [0, 0]]
        map = { positions[0].to_s => true }
        @data.chars.each_with_index do |char, idx|
          pos = positions[idx % 2]
          case char
          when '^' then pos[1] += 1
          when 'v' then pos[1] -= 1
          when '>' then pos[0] += 1
          when '<' then pos[0] -= 1
          end
          map[pos.to_s] = true
        end
        map.count
      end
    end
  end
end
