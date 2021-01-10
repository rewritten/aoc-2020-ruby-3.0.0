# frozen_string_literal: true

require 'aoc/auto_test'
module Aoc
  module Y2020
    class D02
      include Aoc::AutoTest

      solution part_one: 636
      solution part_two: 588

      def initialize(data)
        @data = data
      end

      def part_one
        validate_with do |min, max, letter, password|
          password.count(letter).then { min.to_i <= _1 && _1 <= max.to_i }
        end
      end

      def part_two
        validate_with do |pos1, pos2, letter, password|
          (password[pos1.to_i - 1] == letter) ^ (password[pos2.to_i - 1] == letter)
        end
      end

      private

      def validate_with
        @data.each_line.count do |line|
          /\A(\d+)-(\d+) (.): (.+)\Z/.match(line)&.then { yield _1.captures }
        end
      end
    end
  end
end
