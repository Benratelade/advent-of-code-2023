# frozen_string_literal: true

class Node
  attr_accessor :pipe_type, :x_coord, :y_coord

  def initialize(pipe_type:, x_coord:, y_coord:)
    @pipe_type = pipe_type
    @x_coord = x_coord
    @y_coord = y_coord
  end

  def connected_nodes
    case pipe_type
    when "|"
      { north: coordinates_at(:north), south: coordinates_at(:south) }
    when "-"
      { east: coordinates_at(:east), west: coordinates_at(:west) }
    when "L"
      { north: coordinates_at(:north), east: coordinates_at(:east) }
    when "J"
      { north: coordinates_at(:north), west: coordinates_at(:west) }
    when "7"
      { south: coordinates_at(:south), west: coordinates_at(:west) }
    when "F"
      { south: coordinates_at(:south), east: coordinates_at(:east) }
    when "S"
      []
    when "."
      nil
    end
  end

  def coordinates_at(direction)
    surrounding_coordinates[direction]
  end

  def surrounding_coordinates
    {
      north: {
        x_coord: x_coord,
        y_coord: y_coord - 1,
      },
      east: {
        x_coord: x_coord + 1,
        y_coord: y_coord,
      },
      west: {
        x_coord: x_coord - 1,
        y_coord: y_coord,
      },
      south: {
        x_coord: x_coord,
        y_coord: y_coord + 1,
      },
    }
  end

  def blocking_from_direction(direction)
    return false if pipe_type == "."

    !connected_nodes.keys.include?(Node.opposite_direction(direction))
  end

  def self.opposite_direction(direction)
    opposites = {
      north: :south,
      south: :north,
      west: :east,
      east: :west,
    }

    opposites[direction]
  end
end
