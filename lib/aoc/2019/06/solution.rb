# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2019
    class D06
      include Aoc::AutoTest

      solution part_one: 344_238
      solution part_two: 436

      def initialize(data)
        @data = data.lines.map { _1.strip.split(')').reverse }.to_h
        @cache = Hash.new { |h, k| h[k] = [*@cache[@data[k]], *@data[k]] if k }
        @data.to_a.flatten.each { @cache[_1] }
      end

      def part_one
        @cache.values.sum(&:length)
      end

      def part_two
        initial = @cache['YOU'].zip(@cache['SAN']).count { _1 in [a, ^a] }
        @cache['YOU'].size + @cache['SAN'].size - 2 * initial
      end
    end
  end
end
