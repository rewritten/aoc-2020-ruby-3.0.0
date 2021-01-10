# frozen_string_literal: true

require 'graph'

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D07
      include Aoc::AutoTest

      solution part_one: 296
      solution part_two: 9339

      def initialize(data)
        @edge_data = data.lines.grep(/\A(.+) bags contain (\d.+)\Z/) do
          container, content = Regexp.last_match.captures

          content.scan(/(\d+) (\w+ \w+)/).map do |weight, color|
            [container, color, weight.to_i]
          end
        end.flatten(1)
      end

      def part_one
        g = Hash.new { |h, k| h[k] = [] }
        @edge_data.each { g[_2] << _1 }
        Hash.new { |h, k| h[k] = g[k].map { h[_1] }.reduce(g[k], &:|) }['shiny gold'].size
      end

      def part_two
        g = Hash.new { |h, k| h[k] = [] }
        @edge_data.each { g[_1] << [_2, _3] }
        Hash.new { |h, k| h[k] = g[k].map { h[_1] * _2 }.sum + 1 }['shiny gold'] - 1
      end
    end
  end
end
