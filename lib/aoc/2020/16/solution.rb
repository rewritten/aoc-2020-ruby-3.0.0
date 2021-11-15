# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D16
      include Aoc::AutoTest

      solution part_one: 21_956,
               part_two: 3_709_435_214_239

      def initialize(data)
        data.split("\n\n") => [rules, your_ticket, nearby_tickets]
        @rules = parse_rules(rules.lines)

        @your_ticket = your_ticket.lines.last.strip.split(',').map(&:to_i)
        @nearby_tickets = nearby_tickets.lines.drop(1).map { _1.strip.split(',').map(&:to_i) }
      end

      def part_one
        @nearby_tickets.flat_map { invalid_values _1 }.sum
      end

      def part_two
        @nearby_tickets
          .select { invalid_values(_1).empty? }
          .unshift(@your_ticket)
          .transpose
          .then { find_rules_for_columns _1 }
          .then { uniquify _1 }
          .zip(@your_ticket)
          .select { _1 in [/^departure/, _] }
          .map(&:last)
          .reduce(&:*)
      end

      private

      def parse_rules(lines)
        lines.each_with_object({}) do |line, hash|
          key, range1_start, range1_end, range2_start, range2_end =
            /^(.+): (\d+)-(\d+) or (\d+)-(\d+)$/.match(line.strip).captures
          hash[key] = [(range1_start.to_i..range1_end.to_i), (range2_start.to_i..range2_end.to_i)]
        end
      end

      def invalid_values(ticket)
        ticket.select { |value| @rules.each_value.all? { |ranges| ranges.none? { _1.cover? value } } }
      end

      def find_rules_for_columns(cols)
        cols.each_with_object([]) do |col, acc|
          acc << @rules.keys
                       .reject { acc.include? [_1] }
                       .select { |name| col.all? { |val| @rules[name].any? { _1.cover?(val) } } }
        end
      end

      def uniquify(rules)
        while rules.any? { _1.size > 1 }
          uniques = rules.map { _1.first unless _1.size > 1 }.compact
          rules = rules.map { _1.size > 1 ? _1 - uniques : _1 }
        end
        rules.flatten
      end
    end
  end
end
