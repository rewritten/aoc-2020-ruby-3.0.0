# frozen_string_literal: true

require 'aoc/auto_test'
require_relative '../computer'

module Aoc
  module Y2019
    class D05
      include Aoc::AutoTest

      solution part_one: 7_839_346
      solution part_two: 447_803

      def initialize(data)
        @data = data.split(',').map(&:to_i)
      end

      def part_one
        r = Computer.run(@data)
        r.send(1)

        output = []
        loop { output << r.take }
        output[-2]
      end

      def part_two
        r = Computer.run(@data)
        r.send(5)

        output = []
        loop { output << r.take }
        output[-2]
      end
    end
  end
end
