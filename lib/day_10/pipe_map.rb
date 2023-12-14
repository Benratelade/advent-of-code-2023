# frozen_string_literal: true

require_relative "node"

class PipeMap # rubocop:disable Metrics/ClassLength
  attr_accessor :loop_start, :nodes, :loop, :ground_nodes

  def initialize(array)
    @nodes = []
    @loop = []
    @ground_nodes = []

    array.each_with_index do |rows, y_index|
      @nodes << []
      rows.each_with_index do |pipe, x_index|
        node = Node.new(pipe_type: pipe, x_coord: x_index, y_coord: y_index)
        @loop_start = node if pipe == "S"
        @ground_nodes << node if node.pipe_type == "."
        @nodes[y_index] << node
      end
    end

    set_loop_start_type
    follow_path
  end

  def set_loop_start_type
    valid_directions = []
    @loop_start.surrounding_coordinates.each_key do |direction|
      node = get_surrounding_node(start_node: @loop_start, direction: direction)

      next unless node
      next if node.pipe_type == "."

      next unless get_node_in_direction(
        start_node: node,
        direction: Node.opposite_direction(direction),
      ) == @loop_start

      valid_directions << direction
    end

    case valid_directions.sort
    when %i[north south]
      @loop_start.pipe_type = "|"
    when %i[north west]
      @loop_start.pipe_type = "J"
    when %i[east north]
      @loop_start.pipe_type = "L"
    when %i[east west]
      @loop_start.pipe_type = "-"
    when %i[south west]
      @loop_start.pipe_type = "7"
    when %i[east south]
      @loop_start.pipe_type = "F"
    end
  end

  def get_node_in_direction(start_node:, direction:)
    return nil unless direction
    return nil unless start_node.connected_nodes[direction]

    coordinates = start_node.connected_nodes[direction]

    return nil if outside_bounds(coordinates[:y_coord], coordinates[:x_coord])

    @nodes[coordinates[:y_coord]][coordinates[:x_coord]]
  end

  def get_surrounding_node(start_node:, direction:)
    coordinates = start_node.surrounding_coordinates[direction]

    return nil if outside_bounds(coordinates[:y_coord], coordinates[:x_coord])

    @nodes[coordinates[:y_coord]][coordinates[:x_coord]]
  end

  def outside_bounds(y_coord, x_coord)
    return true if y_coord >= @nodes.length
    return true if y_coord.negative?
    return true if x_coord >= @nodes[0].length
    return true if x_coord.negative?

    false
  end

  def follow_path
    start_node = {
      node: @loop_start,
      origin: @loop_start.connected_nodes.keys.first,
    }

    reached_start = false

    until reached_start
      @loop << start_node[:node]
      start_node = follow_path_from_node(start_node)
      reached_start = true if start_node[:node] == @loop_start
    end
  end

  def follow_path_from_node(start_node)
    destination_direction = start_node[:node].connected_nodes.reject do |key, _value|
                              key == start_node[:origin]
                            end.keys[0]

    {
      node: get_node_in_direction(start_node: start_node[:node], direction: destination_direction),
      origin: Node.opposite_direction(destination_direction),
    }
  end

  def node_is_within_loop(node)
    raise "Not a ground node (pipe_type should be '.')" unless node.pipe_type == "."

    in_loop = true

    %i[north south east west].each do |direction|
      next unless in_loop

      start_node = node
      next_blocking_node = next_blocking_node_in_direction(start_node: start_node, direction: direction)

      next if @loop.include?(next_blocking_node)

      while next_blocking_node || @loop.include?(start_node)
        start_node = next_blocking_node
        next_blocking_node = next_blocking_node_in_direction(start_node: start_node, direction: direction)
      end

      in_loop = false unless next_blocking_node
    end

    in_loop
  end

  def next_blocking_node_in_direction(start_node:, direction:)
    blocking_node = nil
    node = start_node
    reached_edge = false

    until blocking_node
      node = get_surrounding_node(start_node: node, direction: direction)

      unless node
        reached_edge = true
        break
      end

      blocking_node = node if node.blocking_from_direction(direction)
    end

    blocking_node
  end
end
