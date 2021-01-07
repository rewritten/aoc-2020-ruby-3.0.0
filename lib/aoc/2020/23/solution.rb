# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D23
      include Aoc::AutoTest

      example part_one: '67384529', data: '389125467'
      example part_two: 149_245_887_792, data: '389125467'

      solution part_one: '46978532', part_two: 163_035_127_721

      def initialize(data)
        @data = data.chomp.chars.map(&:to_i)
        @by_index = []
      end

      Node = Struct.new(:label, :nxt)

      def part_one
        @mod = 9
        prepare
        100.times { round }

        @current = @by_index[1]

        8.times.map do
          @current = @current.nxt
          @current.label
        end.join
      end

      def part_two
        @mod = 1_000_000
        prepare
        10_000_000.times { round }

        @by_index[1].nxt.label * @by_index[1].nxt.nxt.label
      end

      private

      def prepare
        @data += [*10..@mod]

        n = Node.new

        final = @data.reduce(n) do |node, label|
          @by_index[label] = node.nxt = Node.new(label)
        end

        @current = final.nxt = n.nxt
      end

      def round
        pickup = [@current.nxt, @current.nxt.nxt, @current.nxt.nxt.nxt]

        dest_label = (@current.label - 2) % @mod + 1

        dest_label = (dest_label - 2) % @mod + 1 while pickup.any? { _1.label == dest_label }

        @current.nxt = pickup.last.nxt

        pickup.last.nxt = @by_index[dest_label].nxt
        @by_index[dest_label].nxt = pickup.first

        @current = @current.nxt
      end
    end
  end
end
