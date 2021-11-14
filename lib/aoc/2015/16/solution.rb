# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D16
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 103
      solution part_two: 405

      ACTUAL = { 'children' => 3,
                 'cats' => 7,
                 'samoyeds' => 2,
                 'pomeranians' => 3,
                 'akitas' => 0,
                 'vizslas' => 0,
                 'goldfish' => 5,
                 'trees' => 3,
                 'cars' => 2,
                 'perfumes' => 1 }.freeze

      def initialize(data)
        @data = data
      end

      def part_one
        @data.lines.each do |line|
          number, *remembered = line.match(/Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/).captures
          result = remembered.each_slice(2).all? do |thing, count|
            [thing, count.to_i] in ['children', 3] |
                                   ['cats', 7] |
                                   ['samoyeds', 2] |
                                   ['pomeranians', 3] |
                                   ['akitas', 0] |
                                   ['vizslas', 0] |
                                   ['goldfish', 5] |
                                   ['trees', 3] |
                                   ['cars', 2] |
                                   ['perfumes', 1]
          end

          return number.to_i if result
        end
      end

      def part_two
        @data.lines.each do |line|
          number, *remembered = line.match(/Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/).captures
          result = remembered.each_slice(2).all? do |thing, count|
            [thing, count.to_i] in ['children', 3] |
                                   ['cats', 8..] |
                                   ['samoyeds', 2] |
                                   ['pomeranians', ...3] |
                                   ['akitas', 0] |
                                   ['vizslas', 0] |
                                   ['goldfish', ...5] |
                                   ['trees', 4..] |
                                   ['cars', 2] |
                                   ['perfumes', 1]
          end

          return number.to_i if result
        end
      end
    end
  end
end
