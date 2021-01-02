# frozen_string_literal: true

require 'set'

class Solution
  def initialize(data)
    @numbers = Set.new data.each_line.map(&:to_i)
    @complements = Set.new(@numbers) { 2020 - _1 }
  end

  def part_one
    @numbers
      .find { @complements.include? _1 }
      .then { _1 * (2020 - _1) }
  end

  def part_two
    [*@numbers]
      .combination(2)
      .find { @complements.include? _1.sum }
      .then { _1 * _2 * (2020 - _1 - _2) }
  end
end