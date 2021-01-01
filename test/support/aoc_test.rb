require 'minitest/autorun'
require 'set'

class AocTest < Minitest::Test
  def setup
    @data = File.read("./data/#{self.class.name[/\d+/]}/input.txt")
    @example = File.read("./data/#{self.class.name[/\d+/]}/example.txt")
  end
end
