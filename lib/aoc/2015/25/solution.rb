# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D25
      include Aoc::AutoTest

      solution part_one: 19_980_801

      def initialize(data)
        @row, @column = data.scan(/\d+/).map(&:to_i).map { |n| n - 1 }
      end

      def part_one
        index = @column + (@row + @column + 1) * (@row + @column) / 2

        20_151_125 * bigpow(252_533, index) % 33_554_393
      end

      private

      def bigpow(base, exp)
        return 1 if exp.zero?

        new_exp, odd = exp.divmod(2)
        base**odd * bigpow(base * base, new_exp) % 33_554_393
      end
    end
  end
end
