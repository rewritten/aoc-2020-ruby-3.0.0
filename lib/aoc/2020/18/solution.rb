# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D18
      include Aoc::AutoTest

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
