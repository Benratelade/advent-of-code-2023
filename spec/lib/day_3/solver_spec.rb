# frozen_string_literal: true

require "day_3/solver"
require "pry"

RSpec.describe Solver do
  before do
    @file = File.open("test-file.txt", "w") do |file|
      file << <<~CONTENT
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
      CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".to_matrix" do
    it "turns the input into a matrix of characters" do
      expect(
        Solver.to_matrix("..#..+.58."),
      ).to eq(%w[. . # . . + . 5 8 .])
    end
  end

  describe "#get_numbers_in_line" do
    it "creates an object for each number in the line" do
      solver = Solver.new
      solver.get_numbers_in_line("467..114..", 1)
      expect(solver.numbers[0].value).to eq(467)
      expect(solver.numbers[0].line_index).to eq(1)
      expect(solver.numbers[0].start_index).to eq(0)
      expect(solver.numbers[0].end_index).to eq(2)
      expect(solver.numbers[1].value).to eq(114)
      expect(solver.numbers[1].line_index).to eq(1)
      expect(solver.numbers[1].start_index).to eq(5)
      expect(solver.numbers[1].end_index).to eq(7)
    end
  end

  describe "#process_file" do
    it "iterates through each line in the file" do
      expect(Solver).to receive(:to_matrix).with("467..114..").and_call_original
      expect(Solver).to receive(:to_matrix).with("...*......").and_call_original
      expect(Solver).to receive(:to_matrix).with("..35..633.").and_call_original
      expect(Solver).to receive(:to_matrix).with("......#...").and_call_original
      expect(Solver).to receive(:to_matrix).with("617*......").and_call_original
      expect(Solver).to receive(:to_matrix).with(".....+.58.").and_call_original
      expect(Solver).to receive(:to_matrix).with("..592.....").and_call_original
      expect(Solver).to receive(:to_matrix).with("......755.").and_call_original
      expect(Solver).to receive(:to_matrix).with("...$.*....").and_call_original
      expect(Solver).to receive(:to_matrix).with(".664.598..").and_call_original

      Solver.new.process_file("test-file.txt")
    end

    it "extracts all the numbers in the file" do
      solver = Solver.new
      solver.process_file("test-file.txt")

      expect(solver.numbers[0].value).to eq(467)
      expect(solver.numbers[0].line_index).to eq(0)
      expect(solver.numbers[0].start_index).to eq(0)
      expect(solver.numbers[0].end_index).to eq(2)
      expect(solver.numbers.map(&:value)).to eq(
        [467, 114, 35, 633, 617, 58, 592, 755, 664, 598],
      )
    end

    it "adds the id of each game that matches" do
      expect(Solver.new.process_file("test-file.txt")).to eq([4361, 467_835])
    end
  end

  describe "#part?" do
    it "returns true if a number has adjacent characters in the matrix" do
      solver = Solver.new
      solver.process_file("test-file.txt")

      number = solver.numbers[0]
      expect(solver.part?(number)).to be(true)
    end

    it "returns false if a number des NOT have adjacent characters in the matrix" do
      solver = Solver.new
      solver.process_file("test-file.txt")

      expect(solver.part?(solver.numbers[1])).to be(false)
      expect(solver.part?(solver.numbers[5])).to be(false)
    end
  end

  describe ".adjacent_positions_for" do
    before do
      @solver = Solver.new
      @solver.process_file("test-file.txt")
    end

    it "returns the list of adjacent positions for a number" do
      expect(@solver.adjacent_positions_for(@solver.numbers[0])).to eq(
        [
          [0, 3],
          [1, 0],
          [1, 1],
          [1, 2],
          [1, 3],
        ],
      )

      expect(@solver.adjacent_positions_for(@solver.numbers.last)).to eq(
        [
          [8, 4],
          [8, 5],
          [8, 6],
          [8, 7],
          [8, 8],
          [9, 4],
          [9, 8],
        ],
      )
    end
  end

  describe "#get_stars_in_line" do
    it "gets all the stars in the file" do
      solver = Solver.new
      solver.process_file("test-file.txt")

      expect(solver.stars[0].line_index).to eq(1)
      expect(solver.stars[0].start_index).to eq(3)
      expect(solver.stars[0].end_index).to eq(3)

      expect(solver.stars[1].line_index).to eq(4)
      expect(solver.stars[1].start_index).to eq(3)
      expect(solver.stars[1].end_index).to eq(3)

      expect(solver.stars[2].line_index).to eq(8)
      expect(solver.stars[2].start_index).to eq(5)
      expect(solver.stars[2].end_index).to eq(5)
    end
  end

  describe "#gear?" do
    it "returns true if there are exactly 2 parts around a star" do
      solver = Solver.new
      solver.process_file("test-file.txt")

      expect(solver.gear?(solver.stars[0])).to be(true)
      expect(solver.gear?(solver.stars[2])).to be(true)
    end

    it "returns false if there is only 1 part around a gear" do
      solver = Solver.new
      solver.process_file("test-file.txt")

      expect(solver.gear?(solver.stars[1])).to be(false)
    end
  end
end
