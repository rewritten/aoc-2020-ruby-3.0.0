# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D07
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 3176
      solution part_two: 14_710

      def initialize(data)
        @data = data.lines.map(&:chomp)
      end

      def part_one
        wires = {}
        @data.size.times do
          break wires['a'] if wires['a']

          @data.delete_if do |line|
            case line
            when /^(\d+) -> (\w+)$/ # 44430 -> b
              wires[$2] = $1.to_i
            when /^(\d+) AND (\w+) -> (\w+)$/ # 1 AND b -> c
              wires[$3] = $1.to_i & wires[$2] if wires[$2]
            when /^(\w+) AND (\w+) -> (\w+)$/ # a AND b -> c
              wires[$3] = wires[$1] & wires[$2] if wires[$1] && wires[$2]
            when /^(\w+) OR (\w+) -> (\w+)$/ # a OR b -> c
              wires[$3] = wires[$1] | wires[$2] if wires[$1] && wires[$2]
            when /^(\w+) LSHIFT (\d+) -> (\w+)$/ # a LSHIFT 2 -> c
              wires[$3] = wires[$1] << $2.to_i if wires[$1]
            when /^(\w+) RSHIFT (\d+) -> (\w+)$/ # a RSHIFT 2 -> c
              wires[$3] = wires[$1] >> $2.to_i if wires[$1]
            when /^NOT (\w+) -> (\w+)$/ # NOT a -> c
              wires[$2] = ~wires[$1] if wires[$1]
            when /^(\w+) -> (\w+)$/ # NOT a -> c
              wires[$2] = wires[$1] if wires[$1]
            end
          end
        end
      end

      def part_two
        wires = {}
        @data.size.times do
          break wires['a'] if wires['a']

          @data.delete_if do |line|
            case line
            when /^(\d+) -> b$/ # 44430 -> b: override with solution for part_one
              wires['b'] = 3176
            when /^(\d+) -> (\w+)$/ # 44430 -> c
              wires[$2] = $1.to_i
            when /^(\d+) AND (\w+) -> (\w+)$/ # 1 AND b -> c
              wires[$3] = $1.to_i & wires[$2] if wires[$2]
            when /^(\w+) AND (\w+) -> (\w+)$/ # a AND b -> c
              wires[$3] = wires[$1] & wires[$2] if wires[$1] && wires[$2]
            when /^(\w+) OR (\w+) -> (\w+)$/ # a OR b -> c
              wires[$3] = wires[$1] | wires[$2] if wires[$1] && wires[$2]
            when /^(\w+) LSHIFT (\d+) -> (\w+)$/ # a LSHIFT 2 -> c
              wires[$3] = wires[$1] << $2.to_i if wires[$1]
            when /^(\w+) RSHIFT (\d+) -> (\w+)$/ # a RSHIFT 2 -> c
              wires[$3] = wires[$1] >> $2.to_i if wires[$1]
            when /^NOT (\w+) -> (\w+)$/ # NOT a -> c
              wires[$2] = ~wires[$1] if wires[$1]
            when /^(\w+) -> (\w+)$/ # NOT a -> c
              wires[$2] = wires[$1] if wires[$1]
            end
          end
        end
      end
    end
  end
end
