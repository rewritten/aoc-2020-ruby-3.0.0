# frozen_string_literal: true

require 'aoc/auto_test'
require_relative '../computer'

module Aoc
  module Y2019
    class D02
      include Aoc::AutoTest

      solution part_one: 5_110_675
      solution part_two: 4847

      def initialize(data)
        @data = data.split(',').map(&:to_i)
      end

      def part_one
        @data[1..2] = 1202.divmod 100

        r = Computer.run(@data)
        r.take
      end

      def part_two
        (0...10_000).each do |ans|
          @data[1..2] = ans.divmod 100
          r = Computer.run(@data)
          return ans if r.take == 19_690_720
        end
      end
    end
  end
end
