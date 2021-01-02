# frozen_string_literal: true

require_relative 'support/aoc_test'
require 'passport'

class Day04Test < Minitest::Test
  include AocTest

  def day = 4

  def part_one_example_answer = 2

  def part_one_answer = 196

  def part_two_example_answer = 2

  def part_two_answer = 114

  def part_one_response(data)
    data.split("\n\n").count { Passport.new(_1).all_fields_present? }
  end

  def part_two_response(data)
    data.split("\n\n").count { Passport.new(_1).valid? }
  end
end
