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

      def hand(links, pos, limit = nil)
        c = links[pos]

        d = []

        until d.include?(c) || d.length == limit
          d << c
          c = links[c]
        end

        d
      end


      def display(links, pos)
        puts hand(links, pos).join(' -> ')
      end

      def links_from(hands)
        t = []
        hands.each do |player|
          player.zip(player.rotate).each { t[_1] = _2 }
        end
        t
      end

      def score(deck) = deck.reverse.map.with_index(1) { _1 * _2 }.sum

      def combat(hands, recursive: false)
        seen = Set.new

        len1, len2 = hands.map(&:length)
        left, right = hands.map(&:last)

        links = links_from(hands)

        loop do
          break [1, left] unless seen.add? links.hash
          play1 = links[left]
          play2 = links[right]
          next1 = links[play1]
          next2 = links[play2]

          result =
            if recursive && play1 < len1 && play2 < len2
              hand1 = hand(links, play1, play1)
              hand2 = hand(links, play2, play2)
              combat([hand1, hand2], recursive: true).first
            else
              play1 > play2 ? 1 : 2
            end

          if result == 1
            links[left] = play1
            links[play1] = play2
            links[play2] = next1

            left = play2

            len1 += 1
            len2 -= 1

            break [1, left] if len2.zero?

            links[right] = next2
          else
            links[right] = play2
            links[play2] = play1
            links[play1] = next2

            right = play1

            len2 += 1
            len1 -= 1

            break [2, right] if len1.zero?

            links[left] = next1
          end
        end => [player, pos]

        [player, hand(links, pos)]
      end
    end
  end
end
