# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2016
    class D10
      include Aoc::AutoTest

      solution part_one: '98'
      solution part_two: 4042

      def initialize(data)
        @ops = []

        @targets = {
          'bot' => Hash.new { |h, k| h[k] = [] },
          'output' => Hash.new { |h, k| h[k] = [] }
        }

        data.lines.each do |line|
          # bot 144 gives low to bot 93 and high to bot 153
          # value 61 goes to bot 187
          case line
          when /bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)/
            @ops << Regexp.last_match.captures
          when /value (\d+) goes to bot (\d+)/
            @targets['bot'][$2] << $1.to_i
          end
        end
      end

      def part_one
        loop do
          @targets['bot'].select { |_, v| v in [_, _] }.each do |bot, values|
            lo, hi = values.sort
            return bot if lo == 17 && hi == 61

            _, lo_type, lo_n, hi_type, hi_n = @ops.assoc(bot)

            @targets[lo_type][lo_n] << lo
            @targets[hi_type][hi_n] << hi
            @targets['bot'].delete(bot)
          end
        end
      end

      def part_two
        loop do
          active = @targets['bot'].select { |_, v| v in [_, _] }
          break if active.empty?

          active.each do |bot, values|
            lo, hi = values.sort
            _, lo_type, lo_n, hi_type, hi_n = @ops.assoc(bot)

            @targets[lo_type][lo_n] << lo
            @targets[hi_type][hi_n] << hi
            @targets['bot'].delete(bot)
          end
        end

        @targets['output'].values_at('0', '1', '2').flatten.reduce(&:*)
      end
    end
  end
end
