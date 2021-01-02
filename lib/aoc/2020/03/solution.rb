# frozen_string_literal: true

class Solution
  def initialize(data)
    @data = data.lines.map(&:strip)
    @width = @data.first.size
  end

  def part_one
    each_step(3, 1).count('#')
  end

  def part_two
    [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
      .map { each_step(*_1).count('#') }
      .reduce(&:*)
  end

  private

  def each_step(rgt, dwn)
    return enum_for(:each_step, rgt, dwn) unless block_given?

    x = y = 0
    loop do
      y += dwn
      break if y >= @data.size

      x += rgt
      yield @data[y][x % @width]
    end
  end
end
