# frozen_string_literal: true

require "day_12/springs_list"
require "pry"

RSpec.describe SpringsList do
  describe ".initialize" do
    it "sets the list of springs" do
      springs_list = SpringsList.new([".", "?", "?", ".", ".", "?", "?", ".", ".", ".", "?", "#", "#", "."])

      expect(springs_list.springs).to eq(
        [".", "?", "?", ".", ".", "?", "?", ".", ".", ".", "?", "#", "#", "."],
      )
    end

    it "sets a list of unknown springs" do
      springs_list = SpringsList.new([".", "?", "?", ".", ".", "?", "?", ".", ".", ".", "?", "#", "#", "."])

      expect(springs_list.unknown_springs).to eq(
        [1, 2, 5, 6, 10],
      )
    end
  end

  describe "#all_possible_solutions" do
    it "lists all the possible permutations for a given list of springs" do
      springs_list = SpringsList.new([".", "?", "?", ".", "?"])

      expect(springs_list.all_possible_solutions).to contain_exactly(
        [".", ".", ".", ".", "."],
        [".", ".", ".", ".", "#"],
        [".", ".", "#", ".", "."],
        [".", "#", ".", ".", "."],
        [".", "#", "#", ".", "."],
        [".", "#", ".", ".", "#"],
        [".", ".", "#", ".", "#"],
        [".", "#", "#", ".", "#"],
      )
    end
  end
end
