# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D16
      include Aoc::AutoTest

      bench :uniquify
      bench :find_rules_for_columns

      example part_one: 71, data: <<~TEXT
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
      TEXT

      example part_two: 12 * 11, data: <<~TEXT
        departure class: 0-1 or 4-19
        departure row: 0-5 or 8-19
        seat: 0-13 or 16-19

        your ticket:
        11,12,13

        nearby tickets:
        3,9,18
        15,1,5
        5,14,9
      TEXT

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
