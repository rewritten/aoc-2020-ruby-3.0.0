# frozen_string_literal: true

require_relative 'support/aoc_test'

class Day08Test < Minitest::Test
  include AocTest

  def day = 8

  def part_one_example_answer = 5

  def part_one_answer = 1671

  def part_two_example_answer = 8

  def part_two_answer = 892

  def part_one_response(data)
    HGC.new.run(data.lines.map(&:split)).accumulator
  end

  def part_two_response(data)
    instructions = data.lines.map(&:split)

    instructions
      .each.with_index.lazy
      .select { |(instr, _delta), _index| %w[nop jmp].include?(instr) }
      .map do |(instr, delta), index|
        alt = instr == 'jmp' ? 'nop' : 'jmp'
        HGC.new.with(index => [alt, delta]).run(instructions)
      end
      .select(&:term?).first.accumulator
  end

  class HGC
    attr_reader :accumulator

    def initialize
      @pointer = 0
      @accumulator = 0
      @visited = Set.new
      @replacements = {}
    end

    def with(replacements)
      @replacements = replacements
      self
    end

    def term?
      @status == :term
    end

    def run(instructions)
      loop do
        @status = :loop and break unless @visited.add?(@pointer)
        @status = :term and break if @pointer >= instructions.size

        send(*(@replacements[@pointer] || instructions[@pointer]))
      end

      self
    end

    private

    def nop(_)
      @pointer += 1
    end

    def acc(num)
      @accumulator += num.to_i
      @pointer += 1
    end

    def jmp(num)
      @pointer += num.to_i
    end
  end
end
