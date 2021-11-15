# frozen_string_literal: true

require 'set'
require 'aoc/auto_test'

module Aoc
  module Y2020
    class D08
      include Aoc::AutoTest

      solution part_one: 1671,
               part_two: 892

      def initialize(data)
        @instructions = data.each_line.map do
          _1.split => [k, v]
          [k.to_sym, v.to_i]
        end
      end

      def part_one
        run[1]
      end

      def part_two
        variations.each do |var|
          run(var) => [status, accumulator]
          return accumulator if status == :term
        end
      end

      private

      def run(overrides = {})
        visited = Set.new

        state = [0, 0] # pointer, accumulatore

        loop do
          break [:loop, state[1]] unless visited.add?(state[0])
          break [:term, state[1]] if state[0] >= @instructions.size

          state = send(*(overrides[state[0]] || @instructions[state[0]]), *state)
        end
      end

      def variations
        @instructions.map.with_index do |instr, idx|
          case instr
            in [:nop, d]
              { idx => [:jmp, d] }
            in [:jmp, d]
              { idx => [:nop, d] }
            else
            nil
          end
        end.compact
      end

      def nop(_, pointer, accumulator)
        [pointer + 1, accumulator]
      end

      def acc(num, pointer, accumulator)
        [pointer + 1, accumulator + num]
      end

      def jmp(num, pointer, accumulator)
        [pointer + num, accumulator]
      end
    end
  end
end
