# frozen_string_literal: true

require 'aoc/auto_test'
module Aoc
  module Y2020
    class D02
      include Aoc::AutoTest

      example part_one: 2, part_two: 1, data: <<~TXT
        1-3 a: abcde
        1-3 b: cdefg
        2-9 c: ccccccccc
      TXT

      solution part_one: 636,
               part_two: 588

      def initialize(data)
        @passwords = data.each_line.map do |line|
          range, letter, pw = line.split

          [*range.split('-').map(&:to_i), letter[0], pw]
        end
      end

      def part_one
        @passwords.count do |num1, num2, letter, password|
          (num1..num2).cover? password.count(letter)
        end
      end

      def part_two
        @passwords.count do |num1, num2, letter, password|
          (password[num1 - 1] != letter) ^ (password[num2 - 1] != letter)
        end
      end
    end
  end
end
