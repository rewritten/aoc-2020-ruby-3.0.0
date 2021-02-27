# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2019
    class D03
      include Aoc::AutoTest

      example part_one: 159, data: <<~DATA
        R75,D30,R83,U83,L12,D49,R71,U7,L72
        U62,R66,U55,R34,D71,R55,D58,R83
      DATA

      example part_one: 135, data: <<~DATA
        R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
        U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
      DATA

      solution part_one: 896
      #          part_two: 42

      def initialize(data)
        @data = data.lines.map { |line| to_pieces(line.strip.split(',')) }
      end

      def part_one
        this_wire, other_wire = @data

        this_wire.flat_map { |piece| other_wire.map { |other_piece| cross?(piece, other_piece) } }
                 .compact
                 .map { |x, y| x.abs + y.abs }
                 .sort
                 .reject(&:zero?)
                 .first
      end

      def part_two
        :t
      end

      private

      def to_pieces(directions_ary) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        pieces = []
        last_pos = [0, 0]
        directions_ary.each do |direction|
          len = direction[1..].to_i
          next_pos =
            case direction[0]
            when 'R'
              [last_pos[0] + len, last_pos[1]]
            when 'L'
              [last_pos[0] - len, last_pos[1]]
            when 'U'
              [last_pos[0], last_pos[1] + len]
            when 'D'
              [last_pos[0], last_pos[1] - len]
            end
          pieces << [last_pos, next_pos].sort
          last_pos = next_pos
        end

        pieces
      end

      # returns a point (x, y) when the two pieces cross
      def cross?(this, other) # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
        if this.first.last == this.last.last && other.first.last != other.last.last &&
           other.first.first.between?(this.first.first, this.last.first) &&
           this.last.last.between?(other.first.last, other.last.last)
          [other.first.first, this.last.last]
        elsif this.first.last != this.last.last && other.first.last == other.last.last &&
              this.first.first.between?(other.first.first, other.last.first) &&
              other.last.last.between?(this.first.last, this.last.last)
          [this.first.first, other.last.last]
        end
      end
    end
  end
end
