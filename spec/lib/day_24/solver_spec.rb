# frozen_string_literal: true

require "day_24/solver"
require "pry"

RSpec.describe Solver do
  before do
    File.open("test-file.txt", "w") do |file|
      file << <<~FILE_CONTENT
        19, 13, 30 @ -2,  1, -2
        18, 19, 22 @ -1, -1, -2
        20, 25, 34 @ -2, -2, -4
        12, 31, 28 @ -1, -2, -1
        20, 19, 15 @  1, -5, -3
      FILE_CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".initialize" do
    it "instantiates a hailstone for each row" do
      expect(Hailstone).to receive(:new).with(position: [19, 13, 30], velocity: [-2,  1, -2])
      expect(Hailstone).to receive(:new).with(position: [18, 19, 22], velocity: [-1, -1, -2])
      expect(Hailstone).to receive(:new).with(position: [20, 25, 34], velocity: [-2, -2, -4])
      expect(Hailstone).to receive(:new).with(position: [12, 31, 28], velocity: [-1, -2, -1])
      expect(Hailstone).to receive(:new).with(position: [20, 19, 15], velocity: [1, -5, -3])

      Solver.new("test-file.txt")
    end
  end

  describe ".solve_part_1" do
    it "solves part 1" do
      expect(Solver.new("test-file.txt").solve_part_1((7..27))).to eq(2)
    end
  end
end
