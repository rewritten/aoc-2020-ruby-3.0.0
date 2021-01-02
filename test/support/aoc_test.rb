# frozen_string_literal: true

require 'minitest/autorun'
require 'set'

module AocTest
  def setup
    @example = File.read("./data/#{format('%02d', day)}/example.txt")
    @input = File.read("./data/#{format('%02d', day)}/input.txt")
  end

  def test_part_one_with_example
    assert_equal part_one_example_answer, part_one_response(@example)
  end

  def test_part_one_with_input
    assert_equal part_one_answer, part_one_response(@input)
  end

  def test_part_two_with_example
    assert_equal part_two_example_answer, part_two_response(@example)
  end

  def test_part_two_with_input
    assert_equal part_two_answer, part_two_response(@input)
  end
end
