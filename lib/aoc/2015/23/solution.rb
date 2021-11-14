# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D23
      include Aoc::AutoTest

      solution part_one: 170
      solution part_two: 247

      def initialize(data)
        @data = data.lines.map(&:chomp).map { _1.split(/[ ,]+/) }
      end

      def part_one
        reg = { 'a' => 0, 'b' => 0 }
        run reg
        reg['b']
      end

      def part_two
        reg = { 'a' => 1, 'b' => 0 }
        run reg
        reg['b']
      end

      private

      def run(reg)
        pointer = 0
        loop do
          case @data[pointer]
          in ['hlf', r] then reg[r] /= 2; pointer += 1
          in ['tpl', r] then reg[r] *= 3; pointer += 1
          in ['inc', r] then reg[r] += 1; pointer += 1
          in ['jmp', n] then pointer += n.to_i
          in ['jie', r, n] then pointer += reg[r].even? ? n.to_i : 1
          in ['jio', r, n] then pointer += reg[r] == 1 ? n.to_i : 1
          else break
          end
        end
      end
    end
  end
end
