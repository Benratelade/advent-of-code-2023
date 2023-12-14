# frozen_string_literal: true

require_relative "node"

class PipeMap # rubocop:disable Metrics/ClassLength
  attr_accessor :loop_start, :nodes, :loop, :ground_nodes, :unused_clusters, :unattached_nodes

  def initialize(array)
    @nodes = []
    @loop = []
    @ground_nodes = Set.new
    @unattached_nodes = Set.new
    @unused_clusters = []

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
    set_unattached_nodes
    set_area_clusters
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

  def set_unattached_nodes
    @nodes.each do |row|
      row.each do |node|
        @unattached_nodes.add(node) unless @loop.include?(node)
      end
    end
  end

  def set_area_clusters
    @unattached_nodes.each do |unused_node|
      cluster = Set.new
      cluster.add(unused_node)

      @unused_clusters << grow_area_cluster(cluster: cluster, start_node: unused_node)
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

  def get_surrounding_unused_nodes(start_node:)
    surrounding_unused_nodes = Set.new

    %i[north south east west].each do |direction|
      surrounding_node = get_surrounding_node(start_node: start_node, direction: direction)
      surrounding_unused_nodes << surrounding_node if surrounding_node && !@loop.include?(surrounding_node)
    end

    surrounding_unused_nodes
  end

  def grow_area_cluster(cluster:, start_node:)
    new_nodes = []

    get_surrounding_unused_nodes(start_node: start_node).each do |node|
      next if cluster.include?(node)

      new_nodes << node
      cluster.add(node)
      @unattached_nodes.delete(node)
    end

    new_nodes.each do |node|
      grow_area_cluster(cluster: cluster, start_node: node)
    end

    cluster
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
    in_loop = true

    %i[north south east west].each do |direction|
      start_node = node
      blocked = [false, false]

      all_loop_nodes_in_direction(start_node: start_node, direction: direction).each do |loop_node|
        Node.perpendicular_directions(direction).each_with_index do |perpendicular_direction, index|
          next if blocked[index]

          blocked[index] =
            !get_node_in_direction(
              start_node: loop_node,
              direction: perpendicular_direction,
            ).nil?
        end

        break if blocked.all? { |status| status == true }
      end

      in_loop = false unless blocked.all? { |status| status == true }
    end

    in_loop
  end

  def next_loop_node_in_direction(start_node:, direction:)
    loop_node = nil
    node = start_node

    until loop_node
      node = get_surrounding_node(start_node: node, direction: direction)

      break unless node

      loop_node = node if @loop.include?(node)
    end

    loop_node
  end

  def all_loop_nodes_in_direction(start_node:, direction:)
    loop_nodes = []
    node = start_node

    until node.nil?
      node = get_surrounding_node(start_node: node, direction: direction)

      break unless node

      loop_nodes << node if @loop.include?(node)
    end

    loop_nodes
  end
end
