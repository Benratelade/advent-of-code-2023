# frozen_string_literal: true

require "day_13/valley"
require "pry"

RSpec.describe Valley do
  describe "#initialize" do
    it "creates a matrix based on the string" do
      valley = Valley.new(
        <<~VALLEY,
          #.##..##.
          ..#.##.#.
          ##......#
          ##......#
          ..#.##.#.
          ..##..##.
          #.#.##.#.
        VALLEY
      )

      expect(valley.geography).to eq(
        [
          ["#", ".", "#", "#", ".", ".", "#", "#", "."],
          [".", ".", "#", ".", "#", "#", ".", "#", "."],
          ["#", "#", ".", ".", ".", ".", ".", ".", "#"],
          ["#", "#", ".", ".", ".", ".", ".", ".", "#"],
          [".", ".", "#", ".", "#", "#", ".", "#", "."],
          [".", ".", "#", "#", ".", ".", "#", "#", "."],
          ["#", ".", "#", ".", "#", "#", ".", "#", "."],
        ],
      )
    end
  end

  describe ".line_of_reflection" do
    it "returns information about the line of reflection for a valley with a vertical line of reflection" do
      valley = Valley.new(
        <<~VALLEY,
          #.##..##.
          ..#.##.#.
          ##......#
          ##......#
          ..#.##.#.
          ..##..##.
          #.#.##.#.
        VALLEY
      )

      expect(valley.line_of_reflection).to eq({ horizontal: nil, vertical: [5, 6] })
    end

    it "returns information about the line of reflection for this particular valley" do
      valley = Valley.new(
        <<~VALLEY,
          .####..#.#.#.##..
          ........#..##....
          ..##..#.....#..##
          ......##.##.#####
          ######.#.####....
          ..##....#..##.#..
          .#..#..#####.#...
          ..##...#..#...#.#
          #######.#....####
        VALLEY
      )

      expect(valley.line_of_reflection).to eq({ horizontal: nil, vertical: [3, 4] })
    end

    it "returns information about the line of reflection for a valley with a horizontal line of reflection" do
      valley = Valley.new(
        <<~VALLEY,
          #...##..#
          #....#..#
          ..##..###
          #####.##.
          #####.##.
          ..##..###
          #....#..#
        VALLEY
      )

      expect(valley.line_of_reflection).to eq({ horizontal: [4, 5], vertical: nil })
    end

    it "returns information about both lines of reflection for a valley that's very symmetrical" do
      valley = Valley.new(
        <<~VALLEY,
          #.###..####
          ..#####....
          #.##...####
          ##..#.##..#
          ##.#.##.##.
          ##.#.##.##.
          ##..#.##..#
          #.##...####
          ..#####....
          #.###..####
          .##....#..#
        VALLEY
      )

      expect(valley.line_of_reflection).to eq({ horizontal: [5, 6], vertical: [9, 10] })
    end
  end
end
