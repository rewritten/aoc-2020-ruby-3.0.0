require_relative 'support/aoc_test'

class Day01Test < AocTest
  def setup
    super
    @numbers = Set.new @data.each_line.map(&:to_i)
    @complements = Set.new(@numbers) { 2020 - _1 }
  end

  def test_two_sum
    product = @numbers
              .find { @complements.include? _1 }
              .then { _1 * (2020 - _1) }

    assert_equal 319_531, product
  end

  def test_three_sum
    product = [*@numbers]
              .combination(2)
              .find { @complements.include? _1.sum }
              .then { _1 * _2 * (2020 - _1 - _2) }

    assert_equal 244_300_320, product
  end
end
