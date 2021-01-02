# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D12
      include Aoc::AutoTest[example: [25, 286], input: [1687, 20_873]]

      def initialize(data)
        @data = data.lines.map do
          _1.split(/(?<=\D)(?=\d)/) => [dir, num]
          [dir.downcase, num.to_i]
        end
      end

      def part_one
        ref = Ship.new
        @data.reduce([[0, 0], [1, 0]]) do |acc, elm|
          ref.send(*elm, *acc)
        end.first.map(&:abs).sum
      end

      def part_two
        ref = Waypoint.new
        @data.reduce([[0, 0], [10, 1]]) do |acc, elm|
          ref.send(*elm, *acc)
        end.first.map(&:abs).sum
      end

      class Ref
        def move(distance, position, direction)
          position => [x, y]
          direction => [dx, dy]
          [x + distance * dx, y + distance * dy]
        end

        def rotate(degrees, direction)
          direction => [x, y]
          [x, y, -x, -y, x].each_cons(2).drop(degrees / 90 % 4).first
        end

        def l(degrees, position, direction) = [position, rotate(-degrees, direction)]

        def r(degrees, position, direction) = [position, rotate(degrees, direction)]

        def f(distance, position, direction) = [move(distance, position, direction), direction]
      end

      class Waypoint < Ref
        def n(distance, position, direction) = [position, move(distance, direction, [0, 1])]

        def s(distance, position, direction) = [position, move(distance, direction, [0, -1])]

        def e(distance, position, direction) = [position, move(distance, direction, [1, 0])]

        def w(distance, position, direction) = [position, move(distance, direction, [-1, 0])]
      end

      class Ship < Ref
        def n(distance, position, direction) = [move(distance, position, [0, 1]), direction]

        def s(distance, position, direction) = [move(distance, position, [0, -1]), direction]

        def e(distance, position, direction) = [move(distance, position, [1, 0]), direction]

        def w(distance, position, direction) = [move(distance, position, [-1, 0]), direction]
      end
    end
  end
end
