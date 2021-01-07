# frozen_string_literal: true

require 'aoc/auto_test'
require 'set'

module Aoc
  module Y2020
    class D21
      include Aoc::AutoTest

      example part_one: 5, part_two: 'mxmxvkd,sqjhc,fvjkl', data: <<~TEXT
        mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
        trh fvjkl sbzzf mxmxvkd (contains dairy)
        sqjhc fvjkl (contains soy)
        sqjhc mxmxvkd sbzzf (contains fish)
      TEXT

      solution part_one: 2098, part_two: 'ppdplc,gkcplx,ktlh,msfmt,dqsbql,mvqkdj,ggsz,hbhsx'

      def initialize(data)
        @data = data.lines.map { |line| line.scan(/\w+/).slice_before { _1 == 'contains' }.to_a }
        @data.each { _2.shift }
        @ingredients, @allergenes = @data.transpose.map { Set.new(_1.flatten) }

        init_translations
      end

      def part_one
        non_allergenes = @ingredients - @translations.values
        @data.map(&:first).flatten.select { non_allergenes.include? _1 }.count
      end

      def part_two
        @translations.sort.map { _2 }.join(',')
      end

      private

      def init_translations
        possible_translations = @data.each_with_object({}) do |(words, ingrs), acc|
          ingrs.each do |ingr|
            acc[ingr] ||= Set.new(words)
            acc[ingr] &= words
          end
        end

        @translations = resolve_translations(possible_translations)
      end

      def resolve_translations(possible_translations)
        translations = {}

        until possible_translations.empty?
          possible_translations.each_value { _1.subtract(translations.values) }
          possible_translations.select { _2.size == 1 }.each { translations[_1] = _2.first }
          possible_translations.delete_if { _2.size == 1 }
        end

        translations
      end
    end
  end
end
