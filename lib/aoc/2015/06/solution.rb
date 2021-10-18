# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2015
    class D06
      include Aoc::AutoTest

      # turn off 301,3 through 808,453
      # turn on 351,678 through 951,908
      # toggle 720,196 through 897,994
      RE = /(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/

      # example part_one: 1234,
      #         data: '...'

      # example part_two: 2345,
      #         data: '...'

      solution part_one: 377_891
      solution part_two: 14_110_788

      def initialize(data)
        @data = data.lines.map(&:chomp).map do |line|
          line.match(RE).captures => [action, start_x, start_y, end_x, end_y]
          [action, start_x.to_i, start_y.to_i, end_x.to_i, end_y.to_i]
        end
      end

      def part_one
        grid = Array.new(1000) { Array.new(1000, 0) }

        @data.each do |action, start_x, start_y, end_x, end_y|
          case action
          when 'turn on'
            (start_x..end_x).each do |x|
              (start_y..end_y).each do |y|
                grid[x][y] = 1
              end
            end
          when 'turn off'
            (start_x..end_x).each do |x|
              (start_y..end_y).each do |y|
                grid[x][y] = 0
              end
            end
          when 'toggle'
            (start_x..end_x).each do |x|
              (start_y..end_y).each do |y|
                grid[x][y] = 1 - grid[x][y]
              end
            end
          end
        end

        grid.flatten.count(1)
      end

      def part_two
        grid = Array.new(1000) { Array.new(1000, 0) }

        @data.each do |action, start_x, start_y, end_x, end_y|
          case action
          when 'turn on'
            (start_x..end_x).each do |x|
              (start_y..end_y).each do |y|
                grid[x][y] += 1
              end
            end
          when 'turn off'
            (start_x..end_x).each do |x|
              (start_y..end_y).each do |y|
                grid[x][y] -= 1 if grid[x][y].positive?
              end
            end
          when 'toggle'
            (start_x..end_x).each do |x|
              (start_y..end_y).each do |y|
                grid[x][y] += 2
              end
            end
          end
        end

        grid.flatten.sum
      end
    end
  end
end
