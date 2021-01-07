# frozen_string_literal: true

require 'aoc/auto_test'
require 'set'
module Aoc
  module Y2020
    class D22
      include Aoc::AutoTest

      example part_one: 306, part_two: 291, data: <<~TEXT
        Player 1:
        9
        2
        6
        3
        1

        Player 2:
        5
        8
        4
        7
        10
      TEXT

      solution part_one: 31_308, part_two: 33_647

      def initialize(data)
        @data = data.split("\n\n").map { |t| t.split(':').last.scan(/\d+/).map(&:to_i) }
      end

      def part_one
        recursive_combat(*@data) { _2 > _1 ? 2 : 1 }
          .then { score _2 }
      end

      def part_two
        recursive_combat(*@data) { who_wins_recursive? _1, _2, _3, _4 }
          .then { score _2 }
      end

      private

      def score(deck) = deck.reverse.map.with_index(1) { _1 * _2 }.sum

      def recursive_combat(deck1, deck2, &block)
        seen = Set.new
        loop do
          break [1, deck1] unless seen.add?(deck1 + [0] + deck2)

          round(deck1, deck2, &block)

          break [2, deck2] if deck1.empty?
          break [1, deck1] if deck2.empty?
        end
      end

      def round(deck1, deck2)
        play1 = deck1.shift
        play2 = deck2.shift

        case yield(play1, play2, deck1, deck2)
        when 2 then deck2 << play2 << play1
        when 1 then deck1 << play1 << play2
        end
      end

      def who_wins?(play1, play2) = play2 > play1 ? 2 : 1

      def who_wins_recursive?(play1, play2, deck1, deck2)
        if deck1.size < play1 || deck2.size < play2
          play2 > play1 ? 2 : 1
        else
          recursive_combat(deck1[0...play1].dup, deck2[0...play2].dup, &method(__method__)).first
        end
      end
    end
  end
end
