# frozen_string_literal: true

require 'aoc/auto_test'
require_relative '../computer'

module Aoc
  module Y2019
    class D07
      include Aoc::AutoTest

      example part_one: '43210', data: '3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0'
      #         part_two: 2345,
      #         data: '...'

      # solution part_one: 42
      #          part_two: 42

      def initialize(data)
        @data = data.split(',').map(&:to_i)
      end

      def part_one
        [*0..4].permutation.max_by do |inputs|
          computers = Array.new(5) { Computer.run(@data) }
          computers.zip(inputs).each { _1.send _2 }

          computers.each_cons(2) do |l, r|
            Ractor.new(l, r) { _2.send _1.take }
          end

          computers[0].send(0)

          computers[4].take
        end.join
      end

      def part_two; end
    end
  end
end
