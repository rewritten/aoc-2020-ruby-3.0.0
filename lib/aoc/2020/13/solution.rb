# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D13
      include Aoc::AutoTest

      example part_one: 295, part_two: 1_068_781, data: <<~TXT
        939
        7,13,x,x,59,x,31,19
      TXT

      solution part_one: 6568,
               part_two: 554_865_447_501_099

      def initialize(data)
        data.lines => [ts, buses]
        @curr_timestamp = ts.to_i
        @buses = buses.scan(/\w+/).map(&:to_i)
      end

      def part_one
        waiting = (@curr_timestamp..)
                  .lazy
                  .map { |ts| @buses.reject(&:zero?).find { |bus| ts.modulo(bus).zero? } }
                  .slice_after(Integer)
                  .first
                  .to_a

        waiting.last * (waiting.size - 1)
      end

      def part_two
        @buses
          .map
          .with_index { [_1, _2] unless _1.zero? }
          .compact
          .reduce([0, 1]) do |(t0, step), (bus, delay)|
            t0 += step until (t0 + delay).modulo(bus).zero?
            step *= bus
            [t0 % step, step]
          end
          .reduce(&:modulo)
      end
    end
  end
end
