# frozen_string_literal: true

require_relative 'support/aoc_test'

class Day05Test < Minitest::Test
  include AocTest

  def day = 5

  def part_one_answer = 816

  def part_two_answer = 539

  def part_one_response(data)
    data.lines.map { _1.strip.tr('BFRL', '1010').to_i(2) }.max
  end

  def part_two_response(data)
    seats = Set.new(data.lines) { _1.strip.tr('BFRL', '1010').to_i(2) }

    (1..).lazy
         .drop_while { !seats.include? _1 }
         .drop_while { seats.include? _1 }
         .first
  end

  def test_part_one_with_example = nil

  def test_part_two_with_example = nil
end
