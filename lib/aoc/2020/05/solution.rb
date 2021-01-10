# frozen_string_literal: true

require 'set'
require 'aoc/auto_test'
module Aoc
  module Y2020
    class D05
      include Aoc::AutoTest

      solution part_one: 816
      solution part_two: 539

      def initialize(data)
        @seats = Set.new(data.each_line) { _1.strip.tr('BFRL', '1010').to_i(2) }
      end

      def part_one
        @seats.max
      end

      def part_two
        (1..)
          .lazy
          .drop_while { !@seats.include? _1 }
          .drop_while { @seats.include? _1 }
          .first
      end
    end
  end
end
