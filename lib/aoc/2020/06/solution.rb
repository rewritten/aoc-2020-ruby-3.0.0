# frozen_string_literal: true

class Solution
  def initialize(data)
    @data = data.split("\n\n")
  end

  def part_one
    @data.map { (_1.chars & [*'a'..'z']).count }.sum
  end

  def part_two
    @data.map { _1.lines.map(&:chars).reduce([*'a'..'z'], &:&).count }.sum
  end
end
