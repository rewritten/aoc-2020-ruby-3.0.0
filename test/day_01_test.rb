# frozen_string_literal: true

require_relative 'support/aoc_test'

class Day01Test < Minitest::Test
  include AocTest

  def day = 1

  def part_one_example_answer = 514_579

  def part_one_answer = 319_531

  def part_two_example_answer = 241_861_950

  def part_two_answer = 244_300_320

  private

  def part_one_response(data)
    numbers = Set.new data.each_line.map(&:to_i)
    complements = Set.new(numbers) { 2020 - _1 }
    numbers
      .find { complements.include? _1 }
      .then { _1 * (2020 - _1) }
  end

  def part_two_response(data)
    numbers = Set.new data.each_line.map(&:to_i)
    complements = Set.new(numbers) { 2020 - _1 }
    [*numbers]
      .combination(2)
      .find { complements.include? _1.sum }
      .then { _1 * _2 * (2020 - _1 - _2) }
  end
end
