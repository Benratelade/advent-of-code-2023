# frozen_string_literal: true

require "day_10/solver"
require "pry"

RSpec.describe Solver do
  before do
    File.open("test-file.txt", "w") do |file|
      file << <<~CONTENT
        7-F7-
        .FJ|7
        SJLL7
        |F--J
        LJ.LJ
      CONTENT
    end

    File.open("test-file-2.txt", "w") do |file|
      file << <<~CONTENT
        .F----7F7F7F7F-7....
        .|F--7||||||||FJ....
        .||.FJ||||||||L7....
        FJL7L7LJLJ||LJ.L-7..
        L--J.L7...LJS7F-7L7.
        ....F-J..F7FJ|L7L7L7
        ....L7.F7||L7|.L7L7|
        .....|FJLJ|FJ|F7|.LJ
        ....FJL-7.||.||||...
        ....L---J.LJ.LJLJ...
      CONTENT
    end

    File.open("test-file-3.txt", "w") do |file|
      file << <<~CONTENT
        FF7FSF7F7F7F7F7F---7
        L|LJ||||||||||||F--J
        FL-7LJLJ||||||LJL-77
        F--JF--7||LJLJ7F7FJ-
        L---JF-JLJ.||-FJLJJ7
        |F|F-JF---7F7-L7L|7|
        |FFJF7L7F-JF7|JL---7
        7-L-JL7||F7|L7F-7F7|
        L.L7LFJ|||||FJL7||LJ
        L7JLJL-JLJLJL--JLJ.L
      CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
    File.delete("test-file-2.txt")
    File.delete("test-file-3.txt")
  end

  describe ".initialize" do
    it "instantiates a Map" do
      expect(PipeMap).to receive(:new).with(
        [
          ["7", "-", "F", "7", "-"],
          [".", "F", "J", "|", "7"],
          ["S", "J", "L", "L", "7"],
          ["|", "F", "-", "-", "J"],
          ["L", "J", ".", "L", "J"],
        ],
      )

      Solver.new("test-file.txt")
    end
  end

  describe "#solve_part_1" do
    it "tells you what the furthest distance from the entrance is" do
      solver = Solver.new("test-file.txt")
      expect(solver.solve_part_1).to eq(8)
    end
  end

  describe "#solve_part_2" do
    it "tells you what how many bits of ground are fully enclosed in the loop" do
      # solver = Solver.new("test-file-2.txt")
      # expect(solver.solve_part_2).to eq(8)

      solver = Solver.new("test-file-3.txt")
      expect(solver.solve_part_2).to eq(10)
    end
  end
end
