# frozen_string_literal: true

require "puzzle_2/trebuchet_solver_redo"
require "pry"

RSpec.describe TrebuchetSolverRedo do
  before do
    @file = File.open("test-file.txt", "w") do |file|
      file << <<~CONTENT
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
      CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".get_line_calibration_value" do
    it "returns nothing if there are no digits in a line" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("dhfusdhfuygwuyfguyf")).to eq(0)
    end

    it "returns the outer 2 digits if they are at the beginning and end of the line" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("two1nine")).to eq(29)
    end

    it "returns the outer 2 digits if there are more digits in the line" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("1sd6ifuh2")).to eq(12)
    end

    it "returns the only digit, twice, if there is only 1 digit in the line" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("sdisd7sdfjuh")).to eq(77)
    end

    it "returns the only word digit, twice, if there is only 1 word digit in the line" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("sdisdsevensdfjuh")).to eq(77)
    end

    it "returns the 41 in this sneaky edge case" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("trknlxnv43zxlrqjtwonect")).to eq(41)
    end

    it "returns the 83 in this sneaky edge case" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("bneightwo6eightsevenxl3")).to eq(83)
    end

    it "returns the 32 in this sneaky edge case" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("qljrvrprxthree1fiveeightwoj")).to eq(32)
    end

    it "returns the 12 in this sneaky edge case" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("ztbhdtmxtrbr1ssxmzbvhfiveeightwox")).to eq(12)
    end

    it "returns the 58 in this sneaky edge case" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("xgjskgzkfive3oneighttdt")).to eq(58)
    end

    it "returns the 16 in this sneaky edge case" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("thkoneight54nsix")).to eq(16)
    end

    it "returns the 18 in this sneaky edge case" do
      expect(TrebuchetSolverRedo.get_line_calibration_value("ftoneight3bdbqgtfmsrfive3seveneight")).to eq(18)
    end
  end

  describe ".process_file" do
    it "calls .get_line_calibration_value for each line" do
      expect(TrebuchetSolverRedo).to receive(:get_line_calibration_value).with("two1nine").and_return(1)
      expect(TrebuchetSolverRedo).to receive(:get_line_calibration_value).with("eightwothree").and_return(1)
      expect(TrebuchetSolverRedo).to receive(:get_line_calibration_value).with("abcone2threexyz").and_return(1)
      expect(TrebuchetSolverRedo).to receive(:get_line_calibration_value).with("xtwone3four").and_return(1)
      expect(TrebuchetSolverRedo).to receive(:get_line_calibration_value).with("4nineeightseven2").and_return(1)
      expect(TrebuchetSolverRedo).to receive(:get_line_calibration_value).with("zoneight234").and_return(1)
      expect(TrebuchetSolverRedo).to receive(:get_line_calibration_value).with("7pqrstsixteen").and_return(1)

      TrebuchetSolverRedo.process_file("test-file.txt")
    end

    it "returns the sum of each line's calibration" do
      expect(TrebuchetSolverRedo.process_file("test-file.txt")).to eq(281)
    end
  end
end
