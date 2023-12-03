# frozen_string_literal: true

require "puzzle_3/solver"
require "pry"

RSpec.describe Solver do
  before do
    @file = File.open("test-file.txt", "w") do |file|
      file << <<~CONTENT
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".cubes" do
    it "returns a hash of cube colours and quantities" do
      expect(Solver.cubes).to eq(
        {
          "red" => 12,
          "green" => 13,
          "blue" => 14,
        },
      )
    end
  end

  describe ".get_line_data" do
    it "returns a hash with the game ID and a list of draws" do
      expect(Solver.get_line_data("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")).to eq(
        {
          "id" => 1,
          "draws" => [
            {
              "blue" => 3,
              "red" => 4,
            },
            {
              "blue" => 6,
              "red" => 1,
              "green" => 2,
            },
            {
              "green" => 2,
            },
          ],
        },
      )
    end

    it "gets the right data and ID for the last row" do
      expect(Solver.get_line_data("Game 100: 9 green, 2 blue, 12 red; 2 blue, 14 red, 2 green; 14 red, 12 green")).to eq(
        {
          "id" => 100,
          "draws" => [
            {
              "green" => 9,
              "blue" => 2,
              "red" => 12,
            },
            {
              "blue" => 2,
              "red" => 14,
              "green" => 2,
            },
            {
              "red" => 14,
              "green" => 12,
            },
          ],
        },
      )
    end
  end

  describe ".line_is_possible?" do
    it "returns true if all draws in a game are within the range of possible cubes" do
      expect(
        Solver.line_is_possible?(
          {
            "id" => 1,
            "draws" => [
              { "blue" => 3, "red" => 4 },
              { "red" => 1, "green" => 2, "blue" => 6 },
              { "green" => 2 },
            ],
          },
        ),
      ).to be(true)
    end

    it "returns false if any of the draws in a game have impossible numbers of cubes" do
      expect(
        Solver.line_is_possible?(
          {
            "id" => 3,
            "draws" => [
              { "green" => 8, "blue" => 6, "red" => 20 },
              { "blue" => 5, "red" => 4, "green" => 13 },
              { "green" => 5, "red" => 1 },
            ],
          },
        ),
      ).to be(false)
    end
  end

  describe ".minimum_cubeset" do
    it "returns the minimum number of cubes necessary for a game" do
      expect(Solver.minimum_cubeset("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")).to eq(
        { "red" => 4, "green" => 2, "blue" => 6 },
      )
      expect(Solver.minimum_cubeset("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue")).to eq(
        {
          "red" => 1, "green" => 3, "blue" => 4,
        },
      )
      expect(Solver.minimum_cubeset("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red")).to eq(
        {
          "red" => 20, "green" => 13, "blue" => 6,
        },
      )
      expect(Solver.minimum_cubeset("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red")).to eq(
        {
          "red" => 14, "green" => 3, "blue" => 15,
        },
      )
      expect(Solver.minimum_cubeset("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green")).to eq(
        { "red" => 6, "green" => 3, "blue" => 2 },
      )
    end
  end

  describe ".cubeset_power" do
    it "returns the power of a cubeset" do
      expect(Solver.cubeset_power("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")).to eq(48)
      expect(Solver.cubeset_power("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue")).to eq(12)
      expect(Solver.cubeset_power("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red")).to eq(1560)
      expect(Solver.cubeset_power("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red")).to eq(630)
      expect(Solver.cubeset_power("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green")).to eq(36)
    end
  end

  describe ".process_file" do
    it "iterates through each line in the file" do
      expect(Solver).to receive(:get_line_data).with("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green").and_return({})
      expect(Solver).to receive(:get_line_data).with("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue").and_return({})
      expect(Solver).to receive(:get_line_data).with("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red").and_return({})
      expect(Solver).to receive(:get_line_data).with("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red").and_return({})
      expect(Solver).to receive(:get_line_data).with("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green").and_return({})

      Solver.process_file("test-file.txt")
    end

    it "adds the id of each game that matches" do
      expect(Solver.process_file("test-file.txt")).to eq(8)
    end
  end

  describe ".get_power" do
    it "returns the sum of all cubesets powers" do
      expect(Solver.get_power("test-file.txt")).to eq(2286)
    end
  end
end
