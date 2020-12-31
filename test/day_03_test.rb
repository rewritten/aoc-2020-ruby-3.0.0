require_relative 'support/aoc_test'

class Day03Test < AocTest
  def setup
    super
    @grid = Grid.new(data: @data)
    @stepper = Stepper.new(max_y: @grid.height)
  end

  def test_count_trees
    trees = @stepper.each(3, 1).count { @grid.tree?(x: _1, y: _2) }

    assert_equal 195, trees
  end

  def test_count_trees_various_slopes
    tree_product = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
                   .map { @stepper.each(_1, _2).count { |x, y| @grid.tree?(x: x, y: y) } }
                   .reduce(&:*)

    assert_equal 3_772_314_000, tree_product
  end

  class Grid
    def initialize(data:)
      @data = data.lines.map(&:strip)
      @width = @data.first.size
    end

    def height = @data.size

    def tree?(x:, y:) = @data[y][x % @width] == '#' # rubocop:disable Naming/MethodParameterName
  end

  class Stepper
    def initialize(max_y:)
      @max_y = max_y
    end

    def each(step_x, step_y)
      return enum_for(:each, step_x, step_y) unless block_given?

      cur_x = 0
      cur_y = 0
      loop do
        cur_y += step_y
        break if cur_y >= @max_y

        cur_x += step_x
        yield cur_x, cur_y
      end
    end
  end
end
