# frozen_string_literal: true

require_relative 'support/aoc_test'

class Day09Test < Minitest::Test
  include AocTest

  def day = 9

  def part_one_example_answer = 127

  def part_one_answer = 10_884_537

  def part_two_example_answer = 62

  def part_two_answer = 1_261_309

  def part_one_response(data)
    queue = Q.new(@buffer)

    data.each_line do |line|
      num = line.to_i
      break num unless queue.valid?(num)

      queue << num
    end
  end

  def part_two_response(data)
    invalid_num = part_one_response(data)

    (2..).lazy.each do |n|
      data.each_line.map(&:to_i).each_cons(n).each do |numbers|
        break numbers.minmax.sum if numbers.sum == invalid_num
      end => found

      break found if found
    end
  end

  def test_part_one_with_example
    @buffer = 5
    super
  end

  def test_part_one_with_input
    @buffer = 25
    super
  end

  def test_part_two_with_example
    @buffer = 5
    super
  end

  def test_part_two_with_input
    @buffer = 25
    super
  end

  class Q
    def initialize(buffer_size)
      @buffer_size = buffer_size
      @sums = Hash.new(0)
      @items = []
    end

    def valid?(num)
      @items.size < @buffer_size || (@sums[num]).positive?
    end

    def <<(num)
      @items.each { @sums[_1 + num] += 1 }
      @items << num

      shift if @items.size > @buffer_size
    end

    def shift
      num = @items.shift
      @items.each { @sums[_1 + num] -= 1 }
      num
    end
  end
end
