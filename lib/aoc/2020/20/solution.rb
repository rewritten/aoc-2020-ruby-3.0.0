# frozen_string_literal: true

require 'aoc/auto_test'
require 'set'

module Aoc
  module Y2020
    class D20
      include Aoc::AutoTest

      MONSTER = [
        [18, 0],
        [0, 1], [5, 1], [6, 1], [11, 1], [12, 1], [17, 1], [18, 1], [19, 1],
        [1, 2], [4, 2], [7, 2], [10, 2], [13, 2], [16, 2]
      ].freeze

      example part_one: 20_899_048_083_289, part_two: 273, data: File.read("#{__dir__}/example.txt")

      solution part_one: 29_293_767_579_581, part_two: 1989

      def initialize(data, map: nil)
        @predefined_map = map
        @data = Set.new(data.split("\n\n")) { to_tile _1 }
      end

      def part_one
        uniqs = @data.flat_map { _1[:sides] }.tally.select { _2 == 1 }.keys

        @data.select { (_1[:sides] - uniqs).size == 2 }.map { _1[:id] }.reduce(&:*)
      end

      def part_two
        nullify_edges
        transforms(join_tile(assemble)).map do
          mark_monsters _1
        end.min
      end

      private

      def transforms(map) = 6.times.each_with_object([map, map.transpose]) { _2 << _2[-2].transpose.reverse }

      def join_tile(arr)
        Array.new(arr.size * 8) do |y|
          Array.new(arr.size * 8) do |x|
            xx, xd = x.divmod(8)
            yy, yd = y.divmod(8)
            arr[yy][xx][:map][yd + 1][xd + 1]
          end
        end
      end

      def monster(offset_x, offset_y) = MONSTER.map { [offset_x + _1, offset_y + _2] }

      def monster?(map, monster) = monster.all? { map[_2][_1] == 1 }

      def mark_monsters(map)
        ones = Set.new(blacks(map))

        (0..map.size - 2).each do |y|
          (0..map.size - 19).each do |x|
            monster = monster(x, y)

            ones.subtract(monster) if monster?(map, monster)
          end
        end

        ones.size
      end

      def blacks(map)
        map.flat_map.with_index do |row, y|
          row.map.with_index { [_2, y] if _1 == 1 }
        end.compact
      end

      def nullify_edges
        seen = Set.new
        dupes = Set.new

        @data
          .each { |tile| tile[:sides].each { dupes.add(_1) unless seen.add?(_1) } }
          .each { |tile| tile[:sides].map! { _1 if dupes.include?(_1) } }
      end

      def assemble
        tiles = enum_map_by(@data) { _1[:id] }

        arrangement.tap do |arr|
          arr.each_with_index do |row, y|
            row.map!.with_index do |_, x|
              left = left_constraint(arr, x, y)
              top = top_constraint(arr, x, y)

              enum_map_detect(tiles) { rotate(_2, left, top) }.tap { tiles.delete(_1[:id]) }
            end
          end
        end
      end

      def left_constraint(arr, x, y) = (arr[y][x - 1][:sides][2] unless x.zero?)

      def top_constraint(arr, x, y) = (arr[y - 1][x][:sides][3] unless y.zero?)

      def arrangement = Array.new(Integer.sqrt(@data.count)) { Array.new(Integer.sqrt(@data.count)) }

      def enum_map_by(enum) = enum.map { [yield(_1), _1] }.to_h

      def enum_map_detect(enum) = enum.each { if (r = yield(_1)) then return r end } && nil

      def to_tile(slice)
        id = slice[/\d+/].to_i
        map = slice.scan(/[#.]/).map { _1 == '#' ? 1 : 0 }.each_slice(10).to_a
        {
          id: id,
          map: map,
          sides: [map.map(&:first), map.first, map.map(&:last), map.last].map { [_1, _1.reverse].min.join.to_i(2) }
        }
      end

      def rotate(tile, left, top)
        [tile, tile_transpose(tile)].each do |t|
          if t[:sides] * 2 in [*pre, ^left, ^top, *_]
            pre.size.times { t = tile_rotate(t) }
            return t
          end
        end
        nil
      end

      def tile_rotate(tile) = { id: tile[:id], sides: tile[:sides].rotate, map: tile[:map].transpose.reverse }

      def tile_transpose(tile) = { id: tile[:id], sides: tile[:sides].rotate(2).reverse, map: tile[:map].transpose }
    end
  end
end
