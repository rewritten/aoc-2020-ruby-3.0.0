# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'solution'

class Test < Minitest::Test
  def test_example
    __FILE__
      .then { File.absolute_path '../example.txt', _1 }
      .then { File.read _1 }
      .then { Solution.new _1 } => solution

    assert_equal 514_579, solution.part_one
    assert_equal 241_861_950, solution.part_two
  end

  def test_input
    __FILE__
      .then { File.absolute_path '../input.txt', _1 }
      .then { File.read _1 }
      .then { Solution.new _1 } => solution

    assert_equal 319_531, solution.part_one
    assert_equal 244_300_320, solution.part_two
  end
end
