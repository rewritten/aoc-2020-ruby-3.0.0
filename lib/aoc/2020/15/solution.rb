# frozen_string_literal: true

require 'aoc/auto_test'
require 'set'

module Aoc
  module Y2020
    class D15
      include Aoc::AutoTest

      # example part_one: 436, part_two: 175_594, data: '0,3,6'
      # example part_one: 1, part_two: 2578, data: '1,3,2'
      # example part_one: 10, part_two: 3544142, data: '2,1,3'
      # example part_one: 27, part_two: 261214, data: '1,2,3'
      # example part_one: 78, part_two: 6895259, data: '2,3,1'
      # example part_one: 438, part_two: 18, data: '3,2,1'
      # example part_one: 1836, part_two: 362, data: '3,1,2'

      solution part_one: 371,
               part_two: 352

      def initialize(data)
        @data = data.split(',').map(&:to_i)
      end

      def part_one
        # Game.new(@data).play.drop(2019).first
        Game.new(@data).play(2020)
      end

      def part_two
        Game.new(@data).play(30_000_000)
      end

      class Game
        def initialize(seed)
          @storage = []
          @seed = seed
        end

        def play(turns)
          next_to_say = 0

          @seed.each_with_index do |elm, idx|
            next_to_say = mark_said(elm, idx)
          end

          (@seed.size...turns - 1).each do |turn|
            next_to_say = mark_said(next_to_say, turn)
          end

          next_to_say
        end

        private

        def mark_said(number, turn)
          previous = @storage[number] || turn
          next_to_say = turn - previous
          @storage[number] = turn
          next_to_say
        end
      end
    end
  end
end
