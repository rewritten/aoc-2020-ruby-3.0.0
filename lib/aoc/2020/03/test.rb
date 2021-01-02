# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'solution'

class Test < Minitest::Test
  def test_example
    __FILE__
      .then { File.absolute_path '../example.txt', _1 }
      .then { File.read _1 }
      .then { Solution.new _1 } => solution

    assert_equal 7, solution.part_one
    assert_equal 336, solution.part_two
  end

  def test_input
    __FILE__
      .then { File.absolute_path '../input.txt', _1 }
      .then { File.read _1 }
      .then { Solution.new _1 } => solution

    assert_equal 195, solution.part_one
    assert_equal 3_772_314_000, solution.part_two
  end
end
