# frozen_string_literal: true

require "day_14/solver"
require "pry"

RSpec.describe Solver do
  before do
    File.open("test-file.txt", "w") do |file|
      file << <<~FILE_CONTENT
        O....#....
        O.OO#....#
        .....##...
        OO.#O....O
        .O.....O#.
        O.#..O.#.#
        ..O..#O..O
        .......O..
        #....###..
        #OO..#....
      FILE_CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".solve_part_1" do
    it "calculates the answer to part 1" do
      solver = Solver.new("test-file.txt")

      expect(solver.solve_part_1).to eq(136)
    end
  end

  describe ".solve_part_2" do
    it "calculates the answer to part 2" do
      solver = Solver.new("test-file.txt")

      expect(solver.solve_part_2).to eq(64)
      ## 91286 is the correct answer for part 2
    end
  end
end
