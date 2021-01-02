# frozen_string_literal: true

require_relative 'support/aoc_test'
require 'graph'

class Day07Test < Minitest::Test
  include AocTest

  def day = 7

  def part_one_example_answer = 4

  def part_one_answer = 296

  def part_two_example_answer = 32

  def part_two_answer = 9339

  def part_one_response(data)
    rules(data) do |g, (container, color, _weight)|
      g.add_edge(color, container)
    end.node('shiny gold').traverse.to_a.size - 1
  end

  def part_two_response(data)
    rules(data) do |g, (container, color, weight)|
      g.add_edge(container, color, weight)
    end.node('shiny gold').weight - 1
  end

  def rules(data)
    g = Graph.new

    data.lines.each do |line|
      next [] unless /^(.+) bags contain (\d.+)$/.match(line.strip)

      container, content = Regexp.last_match.captures
      content.scan(/(\d+) (\w+ \w+) bags?/).map do |weight, color|
        yield g, [container, color, weight.to_i]
      end
    end

    g
  end
end
