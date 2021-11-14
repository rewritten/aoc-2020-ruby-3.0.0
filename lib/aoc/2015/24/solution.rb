# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D24
      include Aoc::AutoTest

      solution part_one: 10_439_961_859
      solution part_two: 72_050_269

      def initialize(data)
        @data = data.scan(/\d+/).map(&:to_i)
      end

      def part_one
        find_optimal(@data, into: 3)
      end

      def part_two
        find_optimal(@data, into: 4)
      end

      private

      def find_optimal(numbers, into:)
        target = numbers.sum / into
        1.upto(@data.size - 1) do |i|
          @data
            .combination(i) # subsets of size i
            .select { _1.sum == target } # which have the right sum
            .sort_by { _1.reduce(&:*) } # sort by QE
            .each { return _1.reduce(&:*) if can_split?(@data - _1, into: into - 1) } # which can be further split in 3
        end
      end

      def can_split?(numbers, into: 2)
        return true if into == 1

        sum = numbers.sum / into
        1.upto(numbers.size.div(2)).any? do |i|
          numbers.combination(i).any? { _1.sum == sum && can_split?(numbers - _1, into: into - 1) }
        end
      end
    end
  end
end
