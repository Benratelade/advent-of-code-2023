# frozen_string_literal: true

require "day_11/solver"
require "pry"

RSpec.describe Solver do
  before do
    File.create("test-file.txt", "w") do |file|
      file << <<~CONTENT
        ...#......
        .......#..
        #.........
        ..........
        ......#...
        .#........
        .........#
        ..........
        .......#..
        #...#.....
      CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe "#solve_part_1" do
    it "returns the sum of distances between all galaxies" do
      solver = Solver.new("test-file.txt")

      expect(solver.solve_part_1).to eq(374)
    end
  end
end
