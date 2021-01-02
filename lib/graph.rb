# frozen_string_literal: true

require 'set'

class Graph
  def initialize
    @nodes = {}
    @edges = []
  end

  def add_edge(from_node, to_node, weight = nil)
    @nodes[from_node] ||= Node.new(from_node, [])
    @nodes[to_node] ||= Node.new(to_node, [])

    edge = Edge.new(@nodes[to_node], weight)
    @edges << edge

    @nodes[from_node].edges << edge

    nil
  end

  def node(label) = @nodes.fetch(label)

  Node = Struct.new(:label, :edges) do
    def weight
      @weight ||= 1 + edges.map { _1.weight * _1.to.weight }.sum
    end

    def traverse
      return enum_for(:traverse) unless block_given?

      yield self

      disc = Set.new(q = [self])

      while (v = q.shift)
        v.edges.map(&:to).select { disc.add?(_1) }.each do |w|
          yield w
          q << w
        end
      end
    end
  end

  Edge = Struct.new(:to, :weight)
end
