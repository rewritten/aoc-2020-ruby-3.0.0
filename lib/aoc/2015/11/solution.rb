# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D11
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 'cqjxxyzz'
      solution part_two: 'cqkaabcc'

      def initialize(data)
        @data = data.chomp
      end

      def part_one(init = @data)
        Enumerator
          .produce(init.next, &:next).lazy
          .reject { /[ilo]/.match? _1 }
          .select { /(.)\1.*(.)\2/.match? _1 }
          .select { /abc|bcd|cde|def|efg|fgh|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz/.match? _1 }
          .first
      end

      def part_two
        part_one(part_one)
      end
    end
  end
end
