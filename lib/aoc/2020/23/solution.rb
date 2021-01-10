# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D23
      include Aoc::AutoTest

      solution part_one: '46978532'
      solution part_two: 163_035_127_721

      def initialize(data)
        @data = data.chomp.chars.map(&:to_i)
        @next = @data.each_cons(2).with_object([]) do |(prv, nxt), acc|
          acc[prv] = nxt
        end

        @current = @next[@data.last] = @data.first
      end

      def part_one
        @mod = 9

        100.times { round }

        8.times.each_with_object([1]) { _2 << @next[_2.last] }.drop(1).join
      end

      def part_two
        @mod = 1_000_000

        @next.map! { _1 == @current ? 10 : _1 }
        @next = [*@next, *11..@mod, @current]

        10_000_000.times { round }

        @next[1] * @next[@next[1]]
      end

      private

      # I cannot seem to do better - 5 reads and 2 writes per cycle
      # ~3.00 seconds for part 2
      def round
        x = @next[@current]
        y = @next[x]
        z = @next[y]
        d = @next[z]

        dest = (@current - 2) % @mod + 1
        dest = (dest - 2) % @mod + 1 while dest == x || dest == y || dest == z

        @next[@current] = d
        @next[z] = @next[dest]
        @next[dest] = x

        @current = d
      end
    end
  end
end
