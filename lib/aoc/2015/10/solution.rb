# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D10
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 252_594
      solution part_two: 3_579_328

      def initialize(data)
        @data = data.chomp.chars
      end

      def part_one
        40.times do
          @data = @data.slice_when { |a, b| a != b }.flat_map { [_1.size.to_s, _1.first] }
        end

        @data.size
      end

      def part_two
        50.times do
          @data = @data.slice_when { |a, b| a != b }.flat_map { [_1.size.to_s, _1.first] }
        end

        @data.size
      end
    end
  end
end
