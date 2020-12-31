require_relative 'support/aoc_test'

class Day02Test < AocTest
  def test_count_valid_passwords
    assert_equal 636, count_valid_passwords(method(:guessed_policy))
  end

  def test_count_valid_passwords_official
    assert_equal 588, count_valid_passwords(method(:corrected_policy))
  end

  private

  def count_valid_passwords(strategy)
    @data.each_line.count do |line|
      range, letter, pw = line.split(' ')

      strategy.call(*range.split('-').map(&:to_i), letter[0], pw)
    end
  end

  def guessed_policy(num1, num2, letter, password)
    password.count(letter).then { _1 >= num1 && _1 <= num2 }
  end

  def corrected_policy(num1, num2, letter, password)
    (password[num1 - 1] != letter) ^ (password[num2 - 1] != letter)
  end
end
