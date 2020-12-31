require_relative 'support/aoc_test'
require 'English'
require 'passport'
require 'splitter'

class Day04Test < AocTest
  def setup
    super
    @passports = Splitter.new(sep: :blank_line).split(@data).map { Passport.new(_1) }
    @expected = Set.new(%w[byr iyr eyr hgt hcl ecl pid])
  end

  def test_valid_passports
    assert_equal 196, @passports.count(&:all_fields_present?)
  end

  def test_really_valid_passports
    assert_equal 114, @passports.count(&:valid?)
  end
end
