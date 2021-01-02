# frozen_string_literal: true

require 'minitest/autorun'

module Aoc
  module AutoTest
    def self.make_test_subclass(dir, base, **expectations)
      Class.new(Minitest::Test) do
        expectations.each do |basename, (value_one, value_two)|
          define_method "test_#{basename}" do
            solution = base.new File.read "#{dir}/#{basename}.txt"

            assert_equal value_one, solution.part_one
            assert_equal value_two, solution.part_two
          end
        end
      end
    end

    def self.[](**expectations)
      dir = File.dirname caller_locations.first.absolute_path
      Module.new do
        define_singleton_method :included do |base|
          base.const_set :Test, AutoTest.make_test_subclass(dir, base, **expectations)
        end
      end
    end
  end
end
