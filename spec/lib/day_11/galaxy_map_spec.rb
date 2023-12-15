# frozen_string_literal: true

require "day_11/galaxy_map"
require "pry"

RSpec.describe GalaxyMap do
  describe ".initialize" do
    it "builds a map of galaxies, taking into account the expansion" do
      expect(Galaxy).to receive(:new).with(y_coord: 0, x_coord: 4).and_call_original
      expect(Galaxy).to receive(:new).with(y_coord: 1, x_coord: 9).and_call_original
      expect(Galaxy).to receive(:new).with(y_coord: 2, x_coord: 0).and_call_original
      expect(Galaxy).to receive(:new).with(y_coord: 5, x_coord: 8).and_call_original
      expect(Galaxy).to receive(:new).with(y_coord: 6, x_coord: 1).and_call_original
      expect(Galaxy).to receive(:new).with(y_coord: 7, x_coord: 12).and_call_original
      expect(Galaxy).to receive(:new).with(y_coord: 10, x_coord: 9).and_call_original
      expect(Galaxy).to receive(:new).with(y_coord: 11, x_coord: 0).and_call_original
      expect(Galaxy).to receive(:new).with(y_coord: 11, x_coord: 5).and_call_original

      # [".", ".", ".", ".", "#", ".", ".", ".", ".", ".", ".", ".", "."]
      # [".", ".", ".", ".", ".", ".", ".", ".", ".", "#", ".", ".", "."]
      # ["#", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
      # [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
      # [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
      # [".", ".", ".", ".", ".", ".", ".", ".", "#", ".", ".", ".", "."]
      # [".", "#", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
      # [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "#"]
      # [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
      # [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
      # [".", ".", ".", ".", ".", ".", ".", ".", ".", "#", ".", ".", "."]
      # ["#", ".", ".", ".", ".", "#", ".", ".", ".", ".", ".", ".", "."]

      galaxy_map = GalaxyMap.new(
        [
          [".", ".", ".", "#", ".", ".", ".", ".", ".", "."],
          [".", ".", ".", ".", ".", ".", ".", "#", ".", "."],
          ["#", ".", ".", ".", ".", ".", ".", ".", ".", "."],
          [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
          [".", ".", ".", ".", ".", ".", "#", ".", ".", "."],
          [".", "#", ".", ".", ".", ".", ".", ".", ".", "."],
          [".", ".", ".", ".", ".", ".", ".", ".", ".", "#"],
          [".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
          [".", ".", ".", ".", ".", ".", ".", "#", ".", "."],
          ["#", ".", ".", ".", "#", ".", ".", ".", ".", "."],
        ],
      )

      expect(galaxy_map.galaxies.length).to eq(9)
    end
  end

  describe "#correct_for_expansion" do
    it "expands rows and columns that have only dots" do
      expect(
        GalaxyMap.correct_for_expansion(
          [
            ["."],
          ],
        ),
      ).to eq(
        [
          [".", "."],
          [".", "."],
        ],
      )

      expect(
        GalaxyMap.correct_for_expansion(
          [
            [".", "#"], 
            [".", "#"],
          ],
        ),
      ).to eq(
        [
          [".", ".", "#"],
          [".", ".", "#"],
        ],
      )

      expect(
        GalaxyMap.correct_for_expansion(
          [
            [".", "#", ".", "."],
            [".", ".", ".", "."],
            [".", "#", "#", "."],
            [".", ".", ".", "."],
          ],
        ),
      ).to eq(
        [
          [".", ".", "#", ".", ".", "."],
          [".", ".", ".", ".", ".", "."],
          [".", ".", ".", ".", ".", "."],
          [".", ".", "#", "#", ".", "."],
          [".", ".", ".", ".", ".", "."],
          [".", ".", ".", ".", ".", "."],
        ],
      )
    end
  end
end
