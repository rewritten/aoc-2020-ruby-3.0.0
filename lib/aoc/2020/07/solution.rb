# frozen_string_literal: true

require 'graph'

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D07
      include Aoc::AutoTest

      example part_one: 4, part_two: 32, data: <<~TXT
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
      TXT

      solution part_one: 296,
               part_two: 9339

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
