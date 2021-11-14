# frozen_string_literal: true

require 'prime'
require 'aoc/auto_test'

module Aoc
  module Y2015
    class D20
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 786_240
      solution part_two: 831_600

      def initialize(data)
        @data = data
      end

      def part_one
        # recursive guesses for extremely abundant numbers:
        # https://www.reddit.com/r/adventofcode/comments/po1zel/comment/hd1esc2/?utm_source=share&utm_medium=web2x&context=3
        # < 0.1 seconds

        # sum of divisors (excluding the number)
        expected = @data.to_i / 10

        find_abundant_number(expected, Prime.each(15).to_a.reverse)

        # My naive solution (> 13 seconds):
        # (2..).detect do |n|
        #   Prime.prime_division(n).map { |p, e| (0..e).map { p**_1 }.sum }.inject(:*) >= expected
        # end
      end

      def part_two
        # sum of divisors (excluding the number)
        expected = @data.to_i / 11

        (2..).detect do |n|
          [*1..50].select { (n % _1).zero? }.sum { n.div(_1) } >= expected
        end
      end

      private

      # Find the minimum number whose sum of divisors is >= goal
      def find_abundant_number(goal, primes)
        # Given a number whose prime factorization is p^e * q^f * r^g * ...,
        # the sum of its divisors is (1 + p + ... p**e) * (1 + q + ... q**f) * ...

        # We assume `primes` are already sorted in descending order, and iterate
        # on the first prime, trying all the possible sums-of-powers, checking
        # recursively on the reduced list of primes,

        return goal if primes.empty?

        # point out the biggest prime
        p, *other_primes = primes

        # produces powers and sums
        p_and_s = Enumerator.produce([1, 1]) { |power, sum| [power * p, sum + power * p] }

        # keep only until sum can be used (if it's > goal, it can't be used)
        # this results in a list like [[1, 1], [5, 1+5=6], [25, 6+25=31], [125, 31+125=156], ...]
        p_and_s = p_and_s.take_while { |_, sum| sum <= goal }

        # for each candidate sum-of-powers, find the abundant number for the
        # reduced goal

        results = p_and_s.map do |power, sum|
          # ceil(goal / sum) -> the lef
          new_goal = (goal + sum - 1).div(sum)

          # recursive solution for the reduced goal
          solution = find_abundant_number(new_goal, other_primes)

          # pop back by multiplying by the corresponding power
          solution * power
        end

        results.min
      end
    end
  end
end
