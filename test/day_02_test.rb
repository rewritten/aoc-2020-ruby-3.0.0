# frozen_string_literal: true

require_relative 'support/aoc_test'

class Day02Test < Minitest::Test
  include AocTest

  def day = 2

  def part_one_example_answer = 2

  def part_one_answer = 636

  def part_two_example_answer = 1

  def part_two_answer = 588

  private

  def part_one_response(data)
    count_valid_passwords(data) do |num1, num2, letter, password|
      password.count(letter).then { _1 >= num1 && _1 <= num2 }
    end
  end

  def part_two_response(data)
    count_valid_passwords(data) do |num1, num2, letter, password|
      (password[num1 - 1] != letter) ^ (password[num2 - 1] != letter)
    end
  end

  def count_valid_passwords(data, &strategy)
    data.each_line.count do |line|
      range, letter, pw = line.split

      strategy.call(*range.split('-').map(&:to_i), letter[0], pw)
    end
  end
end
