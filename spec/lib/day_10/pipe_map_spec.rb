# frozen_string_literal: true

require "day_10/pipe_map"
require "pry"

RSpec.describe PipeMap do
  describe ".initialize" do
    it "sets the start of the loop" do
      pipe_map = PipeMap.new(
        [
          ["7", "-", "F", "7", "-"],
          [".", "F", "J", "|", "7"],
          ["S", "J", "L", "L", "7"],
          ["|", "F", "-", "-", "J"],
          ["L", "J", ".", "L", "J"],
        ],
      )

      expect(pipe_map.loop_start.pipe_type).to eq("F")
    end

    it "creates a node for each element in the map" do
      node = double("a node", pipe_type: "a pipe type")

      expect(Node).to receive(:new).with(pipe_type: "7", y_coord: 0, x_coord: 0).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "-", y_coord: 0, x_coord: 1).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "F", y_coord: 0, x_coord: 2).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "7", y_coord: 0, x_coord: 3).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "-", y_coord: 0, x_coord: 4).and_call_original

      expect(Node).to receive(:new).with(pipe_type: ".", y_coord: 1, x_coord: 0).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "F", y_coord: 1, x_coord: 1).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "J", y_coord: 1, x_coord: 2).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "|", y_coord: 1, x_coord: 3).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "7", y_coord: 1, x_coord: 4).and_call_original

      expect(Node).to receive(:new).with(pipe_type: "S", y_coord: 2, x_coord: 0).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "J", y_coord: 2, x_coord: 1).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "L", y_coord: 2, x_coord: 2).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "L", y_coord: 2, x_coord: 3).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "7", y_coord: 2, x_coord: 4).and_call_original

      expect(Node).to receive(:new).with(pipe_type: "|", y_coord: 3, x_coord: 0).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "F", y_coord: 3, x_coord: 1).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "-", y_coord: 3, x_coord: 2).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "-", y_coord: 3, x_coord: 3).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "J", y_coord: 3, x_coord: 4).and_call_original

      expect(Node).to receive(:new).with(pipe_type: "L", y_coord: 4, x_coord: 0).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "J", y_coord: 4, x_coord: 1).and_call_original
      expect(Node).to receive(:new).with(pipe_type: ".", y_coord: 4, x_coord: 2).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "L", y_coord: 4, x_coord: 3).and_call_original
      expect(Node).to receive(:new).with(pipe_type: "J", y_coord: 4, x_coord: 4).and_call_original

      PipeMap.new(
        [
          ["7", "-", "F", "7", "-"],
          [".", "F", "J", "|", "7"],
          ["S", "J", "L", "L", "7"],
          ["|", "F", "-", "-", "J"],
          ["L", "J", ".", "L", "J"],
        ],
      )
    end

    it "saves all ground nodes" do
      pipe_map = PipeMap.new(
        [
          ["7", "-", "F", "7", "-"],
          [".", "F", "J", "|", "7"],
          ["S", "J", "L", "L", "7"],
          ["|", "F", "-", "-", "J"],
          ["L", "J", ".", "L", "J"],
        ],
      )

      expect(pipe_map.ground_nodes).to eq(
        [
          pipe_map.nodes[1][0],
          pipe_map.nodes[4][2],
        ],
      )
    end
  end

  describe "#get_node_in_direction" do
    it "gets the node in the given direction" do
      pipe_map = PipeMap.new(
        [
          ["7", "-", "F", "7", "-"],
          [".", "F", "J", "|", "7"],
          ["S", "J", "L", "L", "7"],
          ["|", "F", "-", "-", "J"],
          ["L", "J", ".", "L", "J"],
        ],
      )

      target_node = pipe_map.get_node_in_direction(start_node: pipe_map.nodes[2][1], direction: :north)
      expect(target_node).to eq(pipe_map.nodes[1][1])
    end
  end

  describe "follow_path_from_node" do
    it "gets to the next node and remembers where it came from" do
      pipe_map = PipeMap.new(
        [
          ["7", "-", "F", "7", "-"],
          [".", "F", "J", "|", "7"],
          ["S", "J", "L", "L", "7"],
          ["|", "F", "-", "-", "J"],
          ["L", "J", ".", "L", "J"],
        ],
      )

      start_node = {
        node: pipe_map.nodes[1][2],
        origin: :west,
      }
      expect(pipe_map.follow_path_from_node(start_node)).to eq(
        {
          node: pipe_map.nodes[0][2],
          origin: :south,
        },
      )
    end
  end

  describe ".node_is_within_loop" do
    before do
      @pipe_map = PipeMap.new(
        [
          [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
          [".", "S", "-", "-", "-", "-", "-", "-", "-", "7", "."],
          [".", "|", "F", "-", "-", "-", "-", "-", "7", "|", "."],
          [".", "|", "|", ".", ".", ".", ".", ".", "|", "|", "."],
          [".", "|", "|", ".", ".", ".", ".", ".", "|", "|", "."],
          [".", "|", "L", "-", "7", ".", "F", "-", "J", "|", "."],
          [".", "|", ".", ".", "|", ".", "|", ".", ".", "|", "."],
          [".", "L", "-", "-", "J", ".", "L", "-", "-", "J", "."],
          [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
        ],
      )
    end

    it "returns true if the node is surrounded by other ground nodes that are surrounded by the loop" do
      expect(@pipe_map.node_is_within_loop(@pipe_map.nodes[6][2])).to be(true)
    end

    it "returns false if the node is not surrounded by the loop" do
      expect(@pipe_map.node_is_within_loop(@pipe_map.nodes[0][0])).to be(false)
    end

    it "returns true even if the node is surrounded by other ground nodes that are not surrounded by the loop" do
      expect(@pipe_map.node_is_within_loop(@pipe_map.nodes[3][3])).to be(true)
    end
  end

  describe ".next_blocking_node_in_direction" do
    before do
      @pipe_map = PipeMap.new(
        [
          [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
          [".", "S", "-", "-", "-", "-", "-", "-", "-", "7", "."],
          [".", "|", "F", "-", "-", "-", "-", "-", "7", "|", "."],
          [".", "|", "|", ".", ".", ".", ".", ".", "|", "|", "."],
          [".", "|", "|", ".", ".", ".", ".", ".", "|", "|", "."],
          [".", "|", "L", "-", "7", ".", "F", "-", "J", "|", "."],
          [".", "|", ".", ".", "|", ".", "|", ".", ".", "|", "."],
          [".", "L", "-", "-", "J", ".", "L", "-", "-", "J", "."],
          [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
        ],
      )
    end

    it "returns the next blocking node in a given direction" do
      from_node = @pipe_map.nodes[4][5]

      expect(@pipe_map.next_blocking_node_in_direction(start_node: from_node, direction: :north)).to eq(@pipe_map.nodes[2][5])
      expect(@pipe_map.next_blocking_node_in_direction(start_node: from_node, direction: :south)).to be_nil
      expect(@pipe_map.next_blocking_node_in_direction(start_node: from_node, direction: :west)).to eq(@pipe_map.nodes[4][2])
      expect(@pipe_map.next_blocking_node_in_direction(start_node: from_node, direction: :east)).to eq(@pipe_map.nodes[4][8])
    end
  end
end
