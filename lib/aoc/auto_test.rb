# frozen_string_literal: true

require 'minitest/autorun'
require 'benchmark'

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

    def self.included(base)
      base.const_set :Test, Class.new(Minitest::Test)
      base.extend ClassMethods
    end

    module ClassMethods
      def example(data: nil, file: nil, label: 'example', opts: {}, **example_expectation)
        data ||= File.read(file)
        this = self
        example_expectation.each do |part, result|
          const_get(:Test).define_method("test_#{label}_#{part}_is_#{result}") do
            solution = this.new(data, **opts)

            assert_equal result, solution.send(part)
          end
        end
      end

      def solution(**args)
        input = File.read("#{File.dirname(caller_locations.first.absolute_path)}/input.txt")
        example(label: 'solution', data: input, **args)
      end

      def bench(meth)
        prepend(Module.new do
          module_eval <<~RUBY, __FILE__, __LINE__ + 1
            # def method_to_benchmark(...)
            #   result = nil
            #   puts __method__, Benchmark.measure(__method__.to_s) { result = super }
            #   result
            # end
            def #{meth}(...)
              result = nil
              puts __method__, Benchmark.measure(__method__.to_s) { result = super }
              result
            end
          RUBY
        end)
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
