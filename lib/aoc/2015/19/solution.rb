# frozen_string_literal: true

require 'set'
require 'aoc/auto_test'

module Aoc
  module Y2015
    class D19
      include Aoc::AutoTest

      solution part_one: 576
      solution part_two: 207

      def initialize(data)
        @data = data.lines.map(&:chomp)

        @molecule = @data.pop
        @data.pop
        @replacements = @data.map { |line| line.split(' => ') }
      end

      def part_one
        repl = Set.new

        @replacements.each do |from, to|
          repl.merge(replace(@molecule, from, to))
        end

        repl.length
      end

      def part_two
        current = [@molecule]

        # only consider so many paths forward, not all of them
        optimistic_guess = (...50)

        (1..).detect do
          current = current
                    .map { |molecule| @replacements.map { |from, to| replace(molecule, to, from) } }
                    .flatten.uniq.sort_by(&:length)[optimistic_guess]

          current.include?('e')
        end
      end

      private

      def replace(current, from, to)
        result = []
        current.scan(Regexp.new(from)) do
          result << $` + to + $' # rubocop:disable Style/PerlBackrefs
        end
        result
      end
    end
  end
end
