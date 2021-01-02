# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'solution'

class Test < Minitest::Test
  def test_example
    __FILE__
      .then { File.absolute_path '../example.txt', _1 }
      .then { File.read _1 }
      .then { Solution.new _1 } => solution

    assert_equal 5, solution.part_one
    assert_equal 8, solution.part_two
  end

  def test_input
    __FILE__
      .then { File.absolute_path '../input.txt', _1 }
      .then { File.read _1 }
      .then { Solution.new _1 } => solution

    assert_equal 1671, solution.part_one
    assert_equal 892, solution.part_two
  end
end
