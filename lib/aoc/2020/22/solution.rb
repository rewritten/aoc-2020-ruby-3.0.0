# frozen_string_literal: true

require 'aoc/auto_test'
require 'set'
module Aoc
  module Y2020
    class D22
      include Aoc::AutoTest

      solution part_one: 31_308
      solution part_two: 33_647

      def initialize(data)
        @data = data.split("\n\n").map { |t| t.split(':').last.scan(/\d+/).map(&:to_i) }
      end

      def part_one
        combat(@data) => [winner, hand]
        score hand
      end

      def part_two
        combat(@data, recursive: true) => [winner, hand]
        score hand
      end

      private

      def score(deck) = deck.reverse.map.with_index(1) { _1 * _2 }.sum

      def combat(hands, recursive: false, nested: false)
        return [0, []] if recursive && nested && shortcut(hands)

        seen = Set.new

        loop do
          return [0, hands[0]] unless seen.add? hands.hash

          apply(hands, compare(hands, recursive: recursive))

          return [0, hands[0]] if hands[1].empty?
          return [1, hands[1]] if hands[0].empty?
        end
      end

      def compare(hands, recursive: false)
        if recursive && hands.all? { _1.first < _1.size }
          combat(hands.map { _1[1.._1.first] }, recursive: true, nested: true).first
        else
          hands[0].first > hands[1].first ? 0 : 1
        end
      end

      def apply(hands, result)
        hands[result] << hands[result].shift << hands[1 - result].shift
      end

      def shortcut(hands) = hands[0].max > [hands[1].max, hands.flatten.length - 2].max
    end
  end
end
