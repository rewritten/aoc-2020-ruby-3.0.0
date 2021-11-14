# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D09
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 207
      solution part_two: 804

      # London to Dublin = 464
      RE = /^(\w+) to (\w+) = (\d+)$/

      def initialize(data)
        @distances = {}
        data.lines.each do |line|
          from, to, distance = line.chomp.match(RE).captures
          @distances[from] ||= {}
          @distances[from][to] = distance.to_i
          @distances[to] ||= {}
          @distances[to][from] = distance.to_i
        end
        @cities = @distances.keys
      end

      def part_one
        @cities.permutation.map do |route|
          route.each_cons(2).map { |from, to| @distances[from][to] }.sum
        end.min
      end

      def part_two
        @cities.permutation.map do |route|
          route.each_cons(2).map { |from, to| @distances[from][to] }.sum
        end.max
      end
    end
  end
end
