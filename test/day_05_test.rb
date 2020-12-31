require_relative 'support/aoc_test'

class Day05Test < AocTest
  def setup
    super
    @passes = @data.lines.map { _1.strip.tr('BFRL', '1010').to_i(2) }
  end

  def test_highest_seat_id
    assert_equal 816, @passes.max
  end

  def test_my_id
    missing = [*1...@passes.max] - @passes

    assert_equal 539, missing.find { @passes.include?(_1 - 1) && @passes.include?(_1 + 1) }
  end
end
