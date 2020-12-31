# frozen_string_literal: true

require_relative 'support/aoc_test'
require 'graph'

class Day07Test < AocTest
  def setup
    super

    @graph = Graph.new
    @lines = @data.lines.flat_map do |line|
      next [] unless /^(.+) bags contain (\d.+)$/.match(line.strip)

      container, content = Regexp.last_match.captures
      content.scan(/(\d+) (.+?) bags?/).map do |weight, color|
        [container, color, weight.to_i]
      end
    end
  end

  def test_count_shiny_gold
    @lines.each do |container, color, weight|
      @graph.add_edge(color, container, weight.to_i)
    end

    @node = @graph.node('shiny gold')

    assert_equal 296, Set.new(@graph.traverse_breadth_first(@node, false)).size
  end

  def test_how_namy_total_bags
    @lines.each do |container, color, weight|
      @graph.add_edge(container, color, weight.to_i)
    end

    @node = @graph.node('shiny gold')

    assert_equal 9339, @node.weight - 1
  end
end
