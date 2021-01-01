require_relative 'support/aoc_test'

class Day01Test < AocTest
  def test_part_one
    assert_equal 514_579, product_of_two(@example)
    assert_equal 319_531, product_of_two(@data)
  end

  def test_part_two
    assert_equal 241_861_950, product_of_three(@example)
    assert_equal 244_300_320, product_of_three(@data)
  end

  private

  def product_of_two(data)
    numbers = Set.new data.each_line.map(&:to_i)
    complements = Set.new(numbers) { 2020 - _1 }
    numbers
      .find { complements.include? _1 }
      .then { _1 * (2020 - _1) }
  end

  def product_of_three(data)
    numbers = Set.new data.each_line.map(&:to_i)
    complements = Set.new(numbers) { 2020 - _1 }
    [*numbers]
      .combination(2)
      .find { complements.include? _1.sum }
      .then { _1 * _2 * (2020 - _1 - _2) }
  end
end
