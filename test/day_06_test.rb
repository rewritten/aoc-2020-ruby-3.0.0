# frozen_string_literal: true

require_relative 'support/aoc_test'
class Day06Test < Minitest::Test
  include AocTest

  def day = 6

  def part_one_example_answer = 11

  def part_one_answer = 6457

  def part_two_example_answer = 6

  def part_two_answer = 3260

  def part_one_response(data)
    data.split("\n\n")
        .map { (_1.chars & [*'a'..'z']).count }
        .sum
  end

  def part_two_response(data)
    data.split("\n\n")
        .map { _1.lines.map(&:chars).reduce([*'a'..'z'], &:&).count }
        .sum
  end
end
