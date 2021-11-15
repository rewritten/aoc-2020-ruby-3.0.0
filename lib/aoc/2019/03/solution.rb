# frozen_string_literal: true

require 'set'
require 'aoc/auto_test'

module Aoc
  module Y2019
    class D03
      include Aoc::AutoTest

      solution part_one: 896
      solution part_two: 16_524

      def initialize(data)
        @data = data.lines.map { _1.strip.split(',') }
      end

      def part_one
        crossings.map { |x, y| x.abs + y.abs }.sort.reject(&:zero?).first
      end

      def part_two
        visited = Hash.new { |h, k| h[k] = [] }

        best = 10 << 100

        wires = @data.map { to_enumerator _1 }

        (1..).zip(*wires) do |turn, pin0, pin1|
          break best unless pin0 || pin1
          break best if turn > best

          visited[pin0][0] ||= turn
          best = best.clamp(..visited[pin0].sum) if visited[pin0][1]

          visited[pin1][1] ||= turn
          best = best.clamp(..visited[pin1].sum) if visited[pin1][0]
        end
      end

      private

      def crossings
        this_wire, other_wire = @data.map { to_pieces _1 }

        this_wire.flat_map { |piece| other_wire.map { |other_piece| cross?(piece, other_piece) } }
                 .compact
      end

      def to_pieces(directions_ary)
        last_pos = [0, 0]
        directions_ary.map do |direction|
          len = direction[1..].to_i
          next_pos, piece =
            case direction[0]
            when 'R'
              [[last_pos[0] + len, last_pos[1]],
               [Range.new(last_pos[0], last_pos[0] + len), Range.new(last_pos[1], last_pos[1])]]
            when 'L'
              [[last_pos[0] - len, last_pos[1]],
               [Range.new(last_pos[0] - len, last_pos[0]), Range.new(last_pos[1], last_pos[1])]]
            when 'U'
              [[last_pos[0], last_pos[1] + len],
               [Range.new(last_pos[0], last_pos[0]), Range.new(last_pos[1], last_pos[1] + len)]]
            when 'D'
              [[last_pos[0], last_pos[1] - len],
               [Range.new(last_pos[0], last_pos[0]), Range.new(last_pos[1] - len, last_pos[1])]]
            end
          last_pos = next_pos
          piece
        end
      end

      STEP = {
        'R' => ->(pos) { [pos[0] + 1, pos[1]] },
        'L' => ->(pos) { [pos[0] - 1, pos[1]] },
        'U' => ->(pos) { [pos[0], pos[1] + 1] },
        'D' => ->(pos) { [pos[0], pos[1] - 1] }
      }.freeze

      def to_enumerator(directions_ary)
        Enumerator.new do |y|
          pos = [0, 0]
          directions_ary.each do |direction|
            step = STEP[direction[0]]
            direction[1..].to_i.times do
              y << pos = step.call(pos)
            end
          end
        end
      end

      # returns a point (x, y) when the two pieces cross
      def cross?(piece_a, piece_b)
        return cross_h_v(piece_a, piece_b) if piece_a.last.size == 1 && piece_b.last.size > 1
        return cross_h_v(piece_b, piece_a) if piece_b.last.size == 1 && piece_a.last.size > 1
      end

      def cross_h_v(hor, ver)
        [ver.first.begin, hor.last.end] if hor.first.cover?(ver.first.begin) && ver.last.cover?(hor.last.end)
      end
    end
  end
end
