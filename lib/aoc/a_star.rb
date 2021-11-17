module Aoc
  class AStar
    class NoPath < StandardError; end

    class Found < StandardError
      attr_reader :position

      def initialize(position)
        super('found')
        @position = position
      end
    end

    Node = Struct.new(:position, :path)

    def initialize(&neighbors)
      @neighbors = neighbors
    end

    def path(start, goal, &neighbors)
      frontier = [Node.new(start, [])]
      backwards_frontier = [Node.new(goal, [])]

      explored = {}
      backwards_explored = {}

      loop do
        step(frontier, explored, backwards_explored, &neighbors)
        step(backwards_frontier, backwards_explored, explored, &neighbors)
      end
    rescue Found => e
      puts "Found! at #{e.position}!"
      explored[e.position] + [e.position] + backwards_explored[e.position].reverse
    end

    private

    def step(frontier, explored, backwards_explored, &neighbors)
      raise NoPath unless frontier.shift in {position: position, path: path}
      return if explored.key? position

      explored[position] = path
      raise Found, position if backwards_explored[position]

      neighbors.call(position).each do |neighbor|
        frontier << Node.new(neighbor, path + [position])
      end
    end
  end
end
