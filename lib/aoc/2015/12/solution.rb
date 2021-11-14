# frozen_string_literal: true

require 'aoc/auto_test'
require 'json'

module Aoc
  module Y2015
    class D12
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 191_164
      solution part_two: 87_842

      def initialize(data)
        @data = data
      end

      def part_one
        @data.scan(/-?\d+/).map(&:to_i).sum
      end

      def part_two
        j = JSON.parse(@data)

        sum = lambda { |item|
          case item
          when Hash
            item.values.include?('red') ? 0 : item.values.map(&sum).sum
          when Array
            item.map(&sum).sum
          when Integer
            item
          else
            0
          end
        }

        sum.call(j)
      end
    end
  end
end
