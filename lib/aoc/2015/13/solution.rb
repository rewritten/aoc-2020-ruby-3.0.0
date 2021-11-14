# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D13
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 709
      solution part_two: 668

      def initialize(data)
        @data = data.lines
      end

      def part_one
        happiness = Hash.new { |h, k| h[k] = {} }
        @data.each do |line|
          # Alice would gain 54 happiness units by sitting next to Bob.
          # Alice would lose 81 happiness units by sitting next to Carol.
          line.chomp.chop.split => [a, _, b, c, _, _, _, _, _, _, d]
          happiness[a][d] = (b == 'gain' ? c.to_i : -c.to_i)
        end

        happiness.keys.permutation.map do |p|
          [*p, p.first].each_cons(2).map { |a, b| happiness[a][b] + happiness[b][a] }.sum
        end.max
      end

      def part_two
        happiness = Hash.new { |h, k| h[k] = {} }
        @data.each do |line|
          # Alice would gain 54 happiness units by sitting next to Bob.
          # Alice would lose 81 happiness units by sitting next to Carol.
          line.chomp.chop.split => [a, _, b, c, _, _, _, _, _, _, d]
          happiness[a][d] = (b == 'gain' ? c.to_i : -c.to_i)
        end

        happiness.keys.permutation.map do |p|
          p.each_cons(2).map { |a, b| happiness[a][b] + happiness[b][a] }.sum
        end.max
      end
    end
  end
end
