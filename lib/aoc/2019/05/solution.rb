# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2019
    class D05
      include Aoc::AutoTest

      solution part_one: 7_839_346
      solution part_two: 447_803

      def initialize(data)
        @data = data.split(',').map(&:to_i)
      end

      def part_one
        @input = [1]
        @output = []
        pos = 0

        loop while (pos = step(pos))

        @output.last
      end

      def part_two
        @input = [5]
        @output = []
        pos = 0

        loop while (pos = step(pos))

        @output.last
      end

      private

      class Reader
        def initialize(data, pos, modes)
          @data = data
          @pos = pos
          @modes = modes
        end

        def [](index)
          if @modes[index - 1] == 1
            @data[@pos + index]
          else
            @data[@data[@pos + index]]
          end
        end
      end

      def step(pos) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
        modes, opcode = @data[pos].divmod 100
        reader = Reader.new(@data, pos, modes.digits)

        case opcode
        when 1 # add
          @data[@data[pos + 3]] = reader[1] + reader[2]
          pos + 4
        when 2 # multiply
          @data[@data[pos + 3]] = reader[1] * reader[2]
          pos + 4
        when 3 # input
          @data[@data[pos + 1]] = @input.pop
          pos + 2
        when 4 # output
          @output << reader[1]
          pos + 2
        when 5 # jump-if-true
          if reader[1].zero?
            pos + 3
          else
            reader[2]
          end
        when 6 # jump-if-false
          if reader[1].zero?
            reader[2]
          else
            pos + 3
          end
        when 7 # less than
          @data[@data[pos + 3]] = reader[1] < reader[2] ? 1 : 0
          pos + 4
        when 8 # equals
          @data[@data[pos + 3]] = reader[1] == reader[2] ? 1 : 0
          pos + 4
        when 99 # halt
          nil
        end
      end

      def read(pos, mode)
        if mode.zero?
          @data[@data[pos]]
        else
          @data[pos]
        end
      end

      def write(pos, mode, value); end
    end
  end
end
