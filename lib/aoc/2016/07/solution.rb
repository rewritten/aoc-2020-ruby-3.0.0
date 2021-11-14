# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2016
    class D07
      include Aoc::AutoTest

      solution part_one: 118
      solution part_two: 260

      def initialize(data)
        @data = data.lines.map { (_1.chomp.split(/[\[\]]/) + ['']).each_slice(2).to_a.transpose }
      end

      def part_one
        @data.count do |supernet_sequences, hypernet_sequences|
          hypernet_sequences.none? { abbas? _1 } && supernet_sequences.any? { abbas? _1 }
        end
      end

      def part_two
        @data.count do |supernet_sequences, hypernet_sequences|
          supernet_abas = supernet_sequences.flat_map { abas _1 }
          hypernet_abas = hypernet_sequences.flat_map { abas _1 }
          supernet_abas.any? { |aba| hypernet_abas.include? aba.rotate }
        end
      end

      private

      def bracketed_abbas?(line)
        line.scan(/(.)(.)\2\1[^\[]*\]/) { return true if Regexp.last_match(1) != Regexp.last_match(2) }
        false
      end

      def abbas?(line)
        line.scan(/(.)(.)\2\1/) { return true if Regexp.last_match(1) != Regexp.last_match(2) }
        false
      end

      # "abaca" => [["a", "b"], ["a", "c"]]
      # "abasssaca" => [["a", "b"], ["a", "c"]]
      # "abaacz" => [["a", "b"]]
      def abas(line)
        line.chars.each_cons(3).select { _1 == _3 && _1 != _2 }.map { _1[...2]}
      end
    end
  end
end
