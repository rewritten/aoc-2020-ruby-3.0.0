# frozen_string_literal: true

require 'set'

require 'aoc/auto_test'
module Aoc
  module Y2020
    class D01
      include Aoc::AutoTest

      solution part_one: 319_531
      solution part_two: 244_300_320

      def initialize(data)
        @numbers = data.scan(/\d+/).map(&:to_i)
        @complements = Set.new(@numbers) { 2020 - _1 }
      end

      def part_one = find(1)

      def part_two = find(2)

      private

      def find(size)
        @numbers
          .combination(size)
          .find { @complements.include? _1.sum }
          .then { _1.reduce(&:*) * (2020 - _1.sum) }
      end
    end
  end
end
