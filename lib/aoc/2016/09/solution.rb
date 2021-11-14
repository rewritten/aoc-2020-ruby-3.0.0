# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2016
    class D09
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 152_851
      solution part_two: 11_797_310_782

      def initialize(data)
        @data = data.chomp
      end

      def part_one
        decompress_length(@data)
      end

      def part_two
        decompress_v2_length(@data)
      end

      private

      def decompress_length(str)
        if (match = str.match(/\((\d+)x(\d+)\)/))
          match.pre_match.size + match[2].to_i * match[1].to_i + send(__callee__, match.post_match[match[1].to_i..])
        else
          str.size
        end
      end

      def decompress_v2_length(str)
        if (match = str.match(/\((\d+)x(\d+)\)/))
          match.pre_match.size +
            match[2].to_i * send(__callee__, match.post_match[...match[1].to_i]) +
            send(__callee__, match.post_match[match[1].to_i..])
        else
          str.size
        end
      end
    end
  end
end
