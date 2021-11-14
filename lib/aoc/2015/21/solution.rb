# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D21
      include Aoc::AutoTest

      class ::Integer
        def cdiv(other)
          (self + other - 1).div(other)
        end
      end

      solution part_one: 91
      solution part_two: 158

      DAGGERS = [
        [8, 4, 0],
        [10, 5, 0],
        [25, 6, 0],
        [40, 7, 0],
        [74, 8, 0]
      ].freeze

      ARMORS = [
        [13, 0, 1],
        [31, 0, 2],
        [53, 0, 3],
        [75, 0, 4],
        [102, 0, 5]
      ].freeze

      RINGS = [
        [25, 1, 0],
        [50, 2, 0],
        [100, 3, 0],
        [20, 0, 1],
        [40, 0, 2],
        [80, 0, 3]
      ].freeze

      def initialize(data)
        @data = data
        @boss_hp, @boss_dam, @boss_arm = data.scan(/\d+/).map(&:to_i)

        @sets = DAGGERS.combination(1).flat_map do |daggers|
          (ARMORS.combination(0) + ARMORS.combination(1)).flat_map do |armors|
            (RINGS.combination(0) + RINGS.combination(1) + RINGS.combination(2)).map do |rings|
              (daggers + armors + rings).transpose.map(&:sum)
            end
          end
        end
      end

      def part_one
        @sets.sort.detect { game _1 }.first
      end

      def part_two
        @sets.sort.reverse.detect { !game(_1) }.first
      end

      private

      def game(set)
        _, dam, arm = set
        turns_to_kill_boss = @boss_hp.cdiv((dam - @boss_arm).clamp(1..))
        turns_to_die = 100.cdiv((@boss_dam - arm).clamp(1..))
        turns_to_kill_boss <= turns_to_die
      end
    end
  end
end
