# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2019
    class D02
      include Aoc::AutoTest

      solution part_one: 5_110_675
      solution part_two: 4847

      def initialize(data)
        @data = data.split(',').map(&:to_i)
      end

      def part_one
        pos = 0
        @data[1..2] = 1202.divmod 100

        pos = step(pos) while pos

        @data[0]
      end

      def part_two
        @original = @data

        (0...10_000).each do |ans|
          @data = [*@original]
          pos = 0
          @data[1..2] = ans.divmod 100

          pos = step(pos) while pos

          return ans if @data[0] == 19_690_720
        end
      end

      private

      def step(pos) # rubocop:disable Metrics/AbcSize
        case @data[pos]
        when 1 # add
          @data[@data[pos + 3]] = @data[@data[pos + 1]] + @data[@data[pos + 2]]
          pos + 4
        when 2 # multiply
          @data[@data[pos + 3]] = @data[@data[pos + 1]] * @data[@data[pos + 2]]
          pos + 4
        when 99 # halt
          nil
        end
      end
    end
  end
end
