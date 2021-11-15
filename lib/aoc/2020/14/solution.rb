# frozen_string_literal: true

require 'aoc/auto_test'

module Aoc
  module Y2020
    class D14
      include Aoc::AutoTest

      solution part_one: 14_553_106_347_726,
               part_two: 2_737_766_154_126

      def initialize(data)
        @data = data.lines
      end

      def part_one
        d = DecoderV1.new
        @data.each do |line|
          d << line
        end
        d.sum
      end

      def part_two
        d = DecoderV2.new
        @data.each do |line|
          d << line
        end
        d.sum
      end

      class Decoder
        def initialize
          @storage = {}
        end

        def <<(line)
          case line.strip
          when /^mask = ([01X]{36})$/
            @mask = Regexp.last_match[1]
          when /^mem\[(\d+)\] = (\d+)$/
            store(Regexp.last_match[1].to_i, Regexp.last_match[2].to_i)
          end
        end

        def sum
          @storage.values.sum
        end
      end

      class DecoderV1 < Decoder
        def store(addr, val)
          @storage[addr] = val & @mask.tr('X', '1').to_i(2) | @mask.tr('X', '0').to_i(2)
        end
      end

      class DecoderV2 < Decoder
        def store(addr, val)
          q = [format('%036b', addr).chars.zip(@mask.chars).map { |a, m| m == '0' ? a : m }.join]
          while (m = q.shift)
            if m.include? 'X'
              q << m.sub('X', '0')
              q << m.sub('X', '1')
            else
              @storage[m] = val
            end
          end
        end
      end
    end
  end
end
