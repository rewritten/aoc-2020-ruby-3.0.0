# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2016
    class D02
      include Aoc::AutoTest

      solution part_one: '56983'
      solution part_two: '8B8B1'

      DIRS = {
        'U' => +1i,
        'D' => -1i,
        'L' => -1,
        'R' => +1
      }.freeze

      def initialize(data)
        @data = data.lines.map(&:chomp)
      end

      def part_one
        solve <<~KEYPAD
          1 2 3
          4 5 6
          7 8 9
        KEYPAD
      end

      def part_two
        solve <<~KEYPAD
              1
            2 3 4
          5 6 7 8 9
            A B C
              D
        KEYPAD
      end

      private

      def solve(keypad)
        mapping = {}
        keypad.lines.each_with_index do |line, y|
          line.chomp.chars.each_with_index do |char, x|
            mapping[char] = x / 2 - 1i * y unless char == ' '
          end
        end

        buttons = mapping.invert

        @data.each_with_object(['5']) do |line, acc|
          line
            .chars
            .reduce(acc.last) { |button, dir| buttons.fetch(mapping[button] + DIRS[dir], button) }
            .tap { |button| acc << button }
        end.drop(1).join
      end
    end
  end
end
