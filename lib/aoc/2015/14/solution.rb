# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D14
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 2655
      solution part_two: 1059

      # Prancer can fly 9 km/s for 12 seconds, but then must rest for 97 seconds.
      RE = %r{can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds}

      def initialize(data)
        @data = data.lines
      end

      def cycles
        @cycles ||=
          @data.map do |line|
            RE.match(line).captures => [vel, dur, rest]
            (Array.new(dur.to_i) { vel.to_i } + Array.new(rest.to_i) { 0 }).cycle.take(2502)
          end
      end

      def part_one
        cycles.map(&:sum).max
      end

      def part_two
        points = Array.new(cycles.size) { 0 }
        positions = Array.new(cycles.size) { 0 }

        cycles[0]
          .zip(*cycles[1..])
          .each do |steps|
            positions.map!.with_index { _1 + steps[_2] }
            max_pos = positions.max
            positions.each_with_index { points[_2] += 1 if _1 == max_pos }
          end

        points.max
      end
    end
  end
end
