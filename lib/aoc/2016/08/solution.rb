# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2016
    class D08
      include Aoc::AutoTest

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 42
      solution part_two: <<~CFLELOYFCS.chomp
         ██  ████ █    ████ █     ██  █   █████  ██   ███
        █  █ █    █    █    █    █  █ █   ██    █  █ █
        █    ███  █    ███  █    █  █  █ █ ███  █    █
        █    █    █    █    █    █  █   █  █    █     ██
        █  █ █    █    █    █    █  █   █  █    █  █    █
         ██  █    ████ ████ ████  ██    █  █     ██  ███
      CFLELOYFCS

      def initialize(data)
        @screen = Array.new(6) { Array.new(50, ' ') }

        data.lines.map(&:chomp).each do |line|
          case line
          when /rect (\d+)x(\d+)/
            x = Regexp.last_match(1).to_i
            y = Regexp.last_match(2).to_i
            y.times { |i| x.times { |j| @screen[i][j] = '█' } }
          when /rotate row y=(\d+) by (\d+)/
            y = Regexp.last_match(1).to_i
            shift = Regexp.last_match(2).to_i
            @screen[y] = @screen[y].rotate(-shift)
          when /rotate column x=(\d+) by (\d+)/
            x = Regexp.last_match(1).to_i
            shift = Regexp.last_match(2).to_i
            @screen = @screen.transpose
            @screen[x] = @screen[x].rotate(-shift)
            @screen = @screen.transpose
          end
        end
      end

      def part_one
        @screen.sum { |row| row.count('█') }
      end

      def part_two
        @screen.map { |row| row.join.rstrip }.join("\n")
      end
    end
  end
end
