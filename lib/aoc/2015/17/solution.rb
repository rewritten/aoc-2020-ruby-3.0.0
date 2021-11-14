# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D17
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 1304
      solution part_two: 18

      def initialize(data)
        @data = data
      end

      def part_one
        combinations(@data.lines.map(&:to_i).sort.reverse, 150).count
      end

      def part_two
        combinations(@data.lines.map(&:to_i).sort.reverse, 150).group_by(&:size).min.last.count
      end

      private

      def combinations(containers, target)
        case [containers, target]
        in _, ...0 then []
        in _, 0 then [[]]
        in [], _ then []
        in [hd, *tl], _ then combinations(tl, target - hd).map { [hd] + _1 } + combinations(tl, target)
        end
      end
    end
  end
end
