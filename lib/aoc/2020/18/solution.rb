# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D18
      include Aoc::AutoTest

      example part_one: 71, part_two: 231, data: '1 + 2 * 3 + 4 * 5 + 6'
      example part_one: 51, part_two: 51, data: '1 + (2 * 3) + (4 * (5 + 6))'
      example part_one: 26, part_two: 46, data: '2 * 3 + (4 * 5)'
      example part_one: 437, part_two: 1445, data: '5 + (8 * 3 + 9 + 3 * 4 * 3)'
      example part_one: 12_240, part_two: 669_060, data: '5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))'
      example part_one: 13_632, part_two: 23_340, data: '((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2'

      solution part_one: 3_159_145_843_816
      solution part_two: 55_699_621_957_369

      def initialize(data)
        @data = data.lines
      end

      def part_one
        @data.map { evaluate_no_precedence _1 }.sum
      end

      def part_two
        @data.map { evaluate_inverted_precedence _1 }.sum
      end

      private

      def evaluate_no_precedence(expression)
        loop while compute_paren(expression) { evaluate_no_precedence _1 }
        loop while compute_op(expression, '+*')
        expression.to_i
      end

      def evaluate_inverted_precedence(expression)
        loop while compute_paren(expression) { evaluate_inverted_precedence _1 }
        loop while compute_op(expression, '+') || compute_op(expression, '*')
        expression.to_i
      end

      def compute_paren(expression)
        expression.sub!(/\(([^()]+)\)/) { yield Regexp.last_match(1) }
      end

      def compute_op(expression, ops)
        expression.sub!(/(\d+) ([#{ops}]) (\d+)/) do
          Regexp.last_match(1).to_i.send(Regexp.last_match(2), Regexp.last_match(3).to_i).to_s
        end
      end
    end
  end
end
