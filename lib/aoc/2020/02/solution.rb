# frozen_string_literal: true

class Solution
  def initialize(data)
    @data = data
  end

  def part_one
    count_valid_passwords(@data) do |num1, num2, letter, password|
      password.count(letter).then { _1 >= num1 && _1 <= num2 }
    end
  end

  def part_two
    count_valid_passwords(@data) do |num1, num2, letter, password|
      (password[num1 - 1] != letter) ^ (password[num2 - 1] != letter)
    end
  end

  private

  def count_valid_passwords(data, &strategy)
    data.each_line.count do |line|
      range, letter, pw = line.split

      strategy.call(*range.split('-').map(&:to_i), letter[0], pw)
    end
  end
end
