# frozen_string_literal: true

require "day_13/solver"
require "pry"

RSpec.describe Solver do
  before do
    File.open("test-file.txt", "w") do |file|
      file << <<~FILE_CONTENT
        #.##..##.
        ..#.##.#.
        ##......#
        ##......#
        ..#.##.#.
        ..##..##.
        #.#.##.#.

        #...##..#
        #....#..#
        ..##..###
        #####.##.
        #####.##.
        ..##..###
        #....#..#
      FILE_CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe "initialize" do
    it "creates a Valley for each valley in the input" do
      expect(Valley).to receive(:new).with(
        <<~FIRST_VALLEY,
          #.##..##.
          ..#.##.#.
          ##......#
          ##......#
          ..#.##.#.
          ..##..##.
          #.#.##.#.
        FIRST_VALLEY
      )

      expect(Valley).to receive(:new).with(
        <<~SECOND_VALLEY,
          #...##..#
          #....#..#
          ..##..###
          #####.##.
          #####.##.
          ..##..###
          #....#..#
        SECOND_VALLEY
      )

      Solver.new("test-file.txt")
    end
  end

  describe ".solve_part_1" do
    it "calculates the answer to part 1" do
      solver = Solver.new("test-file.txt")

      expect(solver.solve_part_1).to eq(405)
    end
  end
end
