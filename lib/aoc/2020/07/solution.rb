# frozen_string_literal: true

require 'graph'

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D07
      include Aoc::AutoTest[example: [4, 32], input: [296, 9339]]

      def initialize(data)
        @edge_data = data.lines.flat_map do |line|
          next [] unless /^(.+) bags contain (\d.+)$/.match(line.strip)

          container, content = Regexp.last_match.captures
          content.scan(/(\d+) (\w+ \w+)/).map do |weight, color|
            [container, color, weight.to_i]
          end
        end
      end

      def part_one
        @edge_data.each_with_object(Graph.new) do |(container, color, _weight), graph|
          graph.add_edge(color, container)
        end.node('shiny gold').traverse.to_a.size - 1
      end

      def part_two
        @edge_data.each_with_object(Graph.new) do |(container, color, weight), graph|
          graph.add_edge(container, color, weight)
        end.node('shiny gold').weight - 1
      end
    end
  end
end
