# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D15
      include Aoc::AutoTest

      # example part_one: 1234
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 222_870
      solution part_two: 117_936

      def initialize(data)
        @data = data
      end

      def part_one
        make_recipes(@data).map { value _1 }.max
      end

      def part_two
        make_recipes(@data).select { check_calories _1, 500 }.map { value _1 }.max
      end

      private

      def make_recipes(data)
        ingreds = data.lines
        weights = ingreds.map { _1.scan(/-?\d+/).map(&:to_i) }

        [*1...100]
          .combination(ingreds.count - 1)
          .map { make_recipe _1, weights }
      end

      def check_calories(recipe, expected_calories)
        recipe.map { |qty, vals| qty * vals.last }.sum == expected_calories
      end

      def make_recipe(cuts, weights)
        [0, *cuts, 100].each_cons(2).map { |x, y| y - x }.zip(weights)
      end

      def value(recipe)
        recipe.map { |qty, ingred| ingred[0..-2].map { _1 * qty } }.transpose.map { _1.sum.clamp(0..1000) }.reduce(&:*)
      end
    end
  end
end
