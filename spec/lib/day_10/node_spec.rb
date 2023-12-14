# frozen_string_literal: true

require "day_10/node"
require "pry"

RSpec.describe Node do
  # | is a vertical pipe connecting north and south.
  # - is a horizontal pipe connecting east and west.
  # L is a 90-degree bend connecting north and east.
  # J is a 90-degree bend connecting north and west.
  # 7 is a 90-degree bend connecting south and west.
  # F is a 90-degree bend connecting south and east.
  # . is ground; there is no pipe in this tile.
  # S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.

  describe "#connected_nodes" do
    it "gives a list of directions where a node is connected" do
      expect(Node.new(pipe_type: "|", x_coord: 2, y_coord: 5).connected_nodes).to eq(
        { north: { x_coord: 2, y_coord: 4 }, south: { x_coord: 2, y_coord: 6 } },
      )
      expect(Node.new(pipe_type: "-", x_coord: 2, y_coord: 5).connected_nodes).to eq(
        { east: { x_coord: 3, y_coord: 5 }, west: { x_coord: 1, y_coord: 5 } },
      )
      expect(Node.new(pipe_type: "L", x_coord: 2, y_coord: 5).connected_nodes).to eq(
        { north: { x_coord: 2, y_coord: 4 }, east: { x_coord: 3, y_coord: 5 } },
      )
      expect(Node.new(pipe_type: "J", x_coord: 2, y_coord: 5).connected_nodes).to eq(
        { north: { x_coord: 2, y_coord: 4 }, west: { x_coord: 1, y_coord: 5 } },
      )
      expect(Node.new(pipe_type: "7", x_coord: 2, y_coord: 5).connected_nodes).to eq(
        { south: { x_coord: 2, y_coord: 6 }, west: { x_coord: 1, y_coord: 5 } },
      )
      expect(Node.new(pipe_type: "F", x_coord: 2, y_coord: 5).connected_nodes).to eq(
        { south: { x_coord: 2, y_coord: 6 }, east: { x_coord: 3, y_coord: 5 } },
      )
      expect(Node.new(pipe_type: ".", x_coord: 2, y_coord: 5).connected_nodes).to eq(nil)
    end
  end

  describe "#surrounding_coordinates" do
    it "returns a set of coordinate for each adjacent position" do
      expect(Node.new(pipe_type: "|", x_coord: 2, y_coord: 5).surrounding_coordinates).to eq(
        {
          north: {
            x_coord: 2,
            y_coord: 4,
          },
          west: {
            x_coord: 1,
            y_coord: 5,
          },
          east: {
            x_coord: 3,
            y_coord: 5,
          },
          south: {
            x_coord: 2,
            y_coord: 6,
          },
        },
      )
    end
  end

  describe ".blocking_from_direction" do
    it "returns true if the node is blocking in the given direction" do
      # 7
      expect(Node.new(pipe_type: "7", x_coord: 0, y_coord: 0).blocking_from_direction(:west)).to be(false)
      expect(Node.new(pipe_type: "7", x_coord: 0, y_coord: 0).blocking_from_direction(:south)).to be(false)

      # |
      expect(Node.new(pipe_type: "|", x_coord: 0, y_coord: 0).blocking_from_direction(:east)).to be(true)
      expect(Node.new(pipe_type: "|", x_coord: 0, y_coord: 0).blocking_from_direction(:west)).to be(true)

      # -
      expect(Node.new(pipe_type: "-", x_coord: 0, y_coord: 0).blocking_from_direction(:north)).to be(true)
      expect(Node.new(pipe_type: "-", x_coord: 0, y_coord: 0).blocking_from_direction(:south)).to be(true)

      # L
      expect(Node.new(pipe_type: "L", x_coord: 0, y_coord: 0).blocking_from_direction(:east)).to be(false)
      expect(Node.new(pipe_type: "L", x_coord: 0, y_coord: 0).blocking_from_direction(:north)).to be(false)

      # F
      expect(Node.new(pipe_type: "F", x_coord: 0, y_coord: 0).blocking_from_direction(:south)).to be(false)
      expect(Node.new(pipe_type: "F", x_coord: 0, y_coord: 0).blocking_from_direction(:east)).to be(false)
    end

    it "returns false if the node is not blocking in the given direction" do
      # .
      expect(Node.new(pipe_type: ".", x_coord: 0, y_coord: 0).blocking_from_direction(:north)).to be(false)
      expect(Node.new(pipe_type: ".", x_coord: 0, y_coord: 0).blocking_from_direction(:south)).to be(false)
      expect(Node.new(pipe_type: ".", x_coord: 0, y_coord: 0).blocking_from_direction(:east)).to be(false)
      expect(Node.new(pipe_type: ".", x_coord: 0, y_coord: 0).blocking_from_direction(:west)).to be(false)

      # 7
      expect(Node.new(pipe_type: "7", x_coord: 0, y_coord: 0).blocking_from_direction(:east)).to be(false)
      expect(Node.new(pipe_type: "7", x_coord: 0, y_coord: 0).blocking_from_direction(:north)).to be(false)

      # |
      expect(Node.new(pipe_type: "|", x_coord: 0, y_coord: 0).blocking_from_direction(:north)).to be(false)
      expect(Node.new(pipe_type: "|", x_coord: 0, y_coord: 0).blocking_from_direction(:south)).to be(false)

      # -
      expect(Node.new(pipe_type: "-", x_coord: 0, y_coord: 0).blocking_from_direction(:east)).to be(false)
      expect(Node.new(pipe_type: "-", x_coord: 0, y_coord: 0).blocking_from_direction(:west)).to be(false)

      # L
      expect(Node.new(pipe_type: "L", x_coord: 0, y_coord: 0).blocking_from_direction(:west)).to be(false)
      expect(Node.new(pipe_type: "L", x_coord: 0, y_coord: 0).blocking_from_direction(:south)).to be(false)

      # F
      expect(Node.new(pipe_type: "F", x_coord: 0, y_coord: 0).blocking_from_direction(:north)).to be(false)
      expect(Node.new(pipe_type: "F", x_coord: 0, y_coord: 0).blocking_from_direction(:west)).to be(false)
    end
  end
end
