# frozen_string_literal: true

require "puzzle_1/trebuchet_solver"
require "pry"

RSpec.describe TrebuchetSolver do
  before do
    File.open("test-file.txt", "w") do |file|
      file << <<~CONTENT
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
      CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".get_line_calibration_value" do
    it "returns nothing if there are no digits in a line" do
      expect(TrebuchetSolver.get_line_calibration_value("dhfusdhfuygwuyfguyf")).to eq(0)
    end

    it "returns the outer 2 digits if they are at the beginning and end of the line" do
      expect(TrebuchetSolver.get_line_calibration_value("1sdifuh2")).to eq(12)
    end

    it "returns the outer 2 digits if there are more digits in the line" do
      expect(TrebuchetSolver.get_line_calibration_value("1sd6ifuh2")).to eq(12)
    end

    it "returns the only digit, twice, if there is only 1 digit in the line" do
      expect(TrebuchetSolver.get_line_calibration_value("sdisd7sdfjuh")).to eq(77)
    end
  end

  describe ".process_file" do
    it "calls .get_line_calibration_value for each line" do
      expect(TrebuchetSolver).to receive(:get_line_calibration_value).with("1abc2").and_return(1)
      expect(TrebuchetSolver).to receive(:get_line_calibration_value).with("pqr3stu8vwx").and_return(1)
      expect(TrebuchetSolver).to receive(:get_line_calibration_value).with("a1b2c3d4e5f").and_return(1)
      expect(TrebuchetSolver).to receive(:get_line_calibration_value).with("treb7uchet").and_return(1)

      TrebuchetSolver.process_file("test-file.txt")
    end

    it "returns the sum of each line's calibration" do
      expect(TrebuchetSolver.process_file("test-file.txt")).to eq(142)
    end
  end
end
