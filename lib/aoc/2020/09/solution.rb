# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D09
      include Aoc::AutoTest[input: [10_884_537, 1_261_309]]

      def initialize(data)
        @data = data.lines.map(&:to_i)
      end

      def buffer = 25

      def part_one
        queue = Q.new(buffer)

        @data.each do |num|
          break num unless queue.valid?(num)

          queue << num
        end
      end

      def part_two
        invalid_num = part_one

        (2..).lazy.each do |n|
          @data.each_cons(n).each do |numbers|
            break numbers.minmax.sum if numbers.sum == invalid_num
          end => found

          break found if found
        end
      end
    end

    class D09Example < D09
      include Aoc::AutoTest[example: [127, 62]]

      def buffer = 5
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
end
