# frozen_string_literal: true

require 'aoc/auto_test'
require 'set'

module Aoc
  module Y2020
    class D19
      include Aoc::AutoTest

      example part_one: 2, data: File.read("#{__dir__}/example.txt")

      example part_one: 3, part_two: 12,
              opts: { cache_start: [42, 31] },
              label: 'example_with_partial_cache',
              data: File.read("#{__dir__}/example_three.txt")

      solution part_one: 250, opts: { cache_start: [42, 31] }
      solution part_two: 359, opts: { cache_start: [42, 31] }

      def initialize(data, cache_start: [0])
        @rule_data, @input = data.split("\n\n")
        @rules = []
        @strings_cache = []
        init_rules(@rule_data)
        cache_start.each { strings _1 }
      end

      def part_one
        @input.lines.grep(/\A#{build_re(0)}\Z/).count
      end

      def part_two
        @input
          .lines
          .grep(/\A(#{build_re(42)}+)(#{build_re(31)}+)\Z/) { Regexp.last_match.captures }
          .count { _1.length > _2.length }
      end

      private

      def build_re(n)
        "(?:#{@strings_cache[n]&.join('|') || @rules[n].map { |seq| seq.map { build_re _1 }.join }.join('|')})"
      end

      def init_rules(data)
        data.lines.each do |line|
          index, definition = line.strip.split(': ')
          @rules[index.to_i] =
            if definition.include?('"')
              [definition.tr('"', '')]
            else
              definition.split(' | ').map { _1.scan(/\d+/).map(&:to_i) }
            end
        end
      end

      def strings(n)
        @strings_cache[n] ||= begin
          case @rules[n]
            in [String]
              @rules[n]
            in alternatives # [[4,4],[5,5]]
              Set.new(alternatives.flat_map do |alt| # [4,4]
                alt.map { strings(_1).to_a }.then { |f, *r| f.product(*r).map(&:join) }
              end)
          end
        end
      end
    end
  end
end
