# frozen_string_literal: true

require 'digest'

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D04
      include Aoc::AutoTest

      # example part_one: 609_043,
      #         data: 'abcdef'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 117_946
      solution part_two: 3_938_038

      def initialize(data)
        @data = data.strip
      end

      def part_one
        (1..).lazy.detect { Digest::MD5.hexdigest(@data + _1.to_s).start_with?('00000') }
      end

      def part_two
        (1..).lazy.detect { Digest::MD5.hexdigest(@data + _1.to_s).start_with?('000000') }
      end
    end
  end
end
