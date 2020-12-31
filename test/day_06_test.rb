require_relative 'support/aoc_test'
require 'splitter'

class Day06Test < AocTest
  def setup
    super
    @groups = Splitter.new(sep: :blank_line).split(@data)
  end

  def test_any_answer_count
    counts = @groups.map { _1.chars.tally.slice(*'a'..'z').count }.sum
    assert_equal 6457, counts
  end

  def test_all_answer_count
    counts = @groups.map { _1.lines.map(&:chars).reduce(&:&).tally.slice(*'a'..'z').count }.sum
    assert_equal 3260, counts
  end
end
