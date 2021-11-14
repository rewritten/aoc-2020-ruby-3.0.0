# frozen_string_literal: true

require 'digest'
require 'aoc/auto_test'

module Aoc
  module Y2016
    class D05
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: '2414bc77'
      solution part_two: '437e60fc'

      def initialize(data)
        @data = data.chomp
      end

      def part_one
        pwd = []

        (0..).each do |i|
          hash = Digest::MD5.hexdigest("#{@data}#{i}")
          next unless hash.start_with?('00000')

          pwd << hash[5]

          break pwd.join if pwd.length == 8
        end

        # (0..)
        #   .lazy
        #   .map { Digest::MD5.hexdigest("#{@data}#{_1}") }
        #   .filter { _1.start_with?('00000') }
        #   .map { _1[5] }
        #   .take(8)
        #   .to_a
        #   .join
      end

      def part_two
        pwd = Array.new(8)

        (0..).each do |i|
          hash = Digest::MD5.hexdigest("#{@data}#{i}")
          next unless hash.start_with?('00000')

          pwd[hash[5].to_i] ||= hash[6] if ('0'..'7').cover? hash[5]

          break pwd.join if pwd.none?(&:nil?)
        end
      end
    end
  end
end
