# frozen_string_literal: true

class Graph
  attr_reader :edges

  def initialize
    @nodes = {}
    @edges = []
  end

  def nodes
    @nodes.values
  end

  def add_edge(from_node, to_node, weight = nil)
    @nodes[from_node] ||= Node.new(from_node)
    @nodes[to_node] ||= Node.new(to_node)

    edge = Edge.new(@nodes[from_node], @nodes[to_node], weight)
    @edges << edge

    @nodes[from_node].add_edge_out(edge)
    @nodes[to_node].add_edge_in(edge)

    nil
  end

  def node(label) = @nodes.fetch(label)

  def traverse_breadth_first(node, with_self = true)
    return enum_for(:traverse_breadth_first, node, with_self) unless block_given?

    yield node if with_self

    node.edges_out.map(&:to_node)
        .each { yield _1 }
        .each { |to| traverse_breadth_first(to, false).each { yield _1 } }
  end

  def traverse_depth_first(node, with_self = true)
    return enum_for(:traverse_depth_first, node) unless block_given?

    yield node if with_self

    node.edges_out.map(&:to_node)
        .each { |to| traverse_depth_first(to).each { yield _1 } }
  end

  class Node
    attr_reader :label, :edges_out, :edges_in

    def initialize(label)
      @label = label
      @edges_out = []
      @edges_in = []
    end

    def add_edge_in(edge) = @edges_in << edge

    def add_edge_out(edge) = @edges_out << edge

    def inspect
      "#<Node: [[#{label}]] -> [ #{edges_out.map { _1.to_node.label }.join(', ')} ]>"
    end

    def weight
      @weight ||= 1 + edges_out.map { |edge| edge.weight * edge.to_node.weight }.sum
    end

    def to_s
      inspect
    end
  end

  class Edge
    attr_reader :from_node, :to_node, :weight

    def initialize(from_node, to_node, weight)
      @from_node = from_node
      @to_node = to_node
      @weight = weight
    end

    def to_s = "#{from_node.label}  -- #{weight} -->  #{to_node.label}"
  end
end
