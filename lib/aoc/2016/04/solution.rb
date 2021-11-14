# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2016
    class D04
      include Aoc::AutoTest

      solution part_one: 137_896
      solution part_two: 501

      def initialize(data)
        @data = data.lines.map { _1.match(/([a-z-]+)-(\d+)\[([a-z]+)\]/).captures }
                    .select { |name, _, checksum| check(name, checksum) }
      end

      def part_one = @data.sum { |_, sector_id, _| sector_id.to_i }

      def part_two
        @data.each do |name, sector_id, _|
          replacements = ('a'..'z').to_a.rotate(sector_id.to_i % 26).join
          return sector_id.to_i if name.tr('a-z', replacements) == 'northpole-object-storage'
        end
      end

      private

      def check(name, checksum)
        name
          .chars
          .tally
          .except('-')
          .to_a
          .sort_by { |ch, v| [-v, ch] }
          .map(&:first)
          .take(5)
          .join == checksum
      end
    end
  end
end
