require 'minitest/autorun'
require 'set'

class AocTest < Minitest::Test
  def setup
    @data = File.read("./data/day_#{self.class.name[/\d+/]}.txt")
  end
end
