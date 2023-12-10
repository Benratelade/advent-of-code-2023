# frozen_string_literal: true

require "day_8/solver"
require "pry"

RSpec.describe Solver do
  before do
    File.open("test-file-1.txt", "w") do |file|
      file << <<~CONTENT
        RL

        AAA = (BBB, CCC)
        BBB = (DDD, EEE)
        CCC = (ZZZ, GGG)
        DDD = (DDD, DDD)
        EEE = (EEE, EEE)
        GGG = (GGG, GGG)
        ZZZ = (ZZZ, ZZZ)
      CONTENT
    end

    File.open("test-file-2.txt", "w") do |file|
      file << <<~CONTENT
        LLR

        AAA = (BBB, BBB)
        BBB = (AAA, ZZZ)
        ZZZ = (ZZZ, ZZZ)
      CONTENT
    end

    File.open("test-file-3.txt", "w") do |file|
      file << <<~CONTENT
        LR

        11A = (11B, XXX)
        11B = (XXX, 11Z)
        11Z = (11B, XXX)
        22A = (22B, XXX)
        22B = (22C, 22C)
        22C = (22Z, 22Z)
        22Z = (22B, 22B)
        XXX = (XXX, XXX)
      CONTENT
    end
  end

  after do
    File.delete("test-file-1.txt")
    File.delete("test-file-2.txt")
    File.delete("test-file-3.txt")
  end

  describe "solve_part_1" do
    describe "file-1" do
      before do
        @solver = Solver.new("test-file-1.txt")
      end

      it "finds ZZZ in 2 steps" do
        expect(@solver.solve_part_1).to eq(2)
      end
    end

    describe "file-2" do
      before do
        @solver = Solver.new("test-file-2.txt")
      end

      it "finds ZZZ in 6 steps" do
        expect(@solver.solve_part_1).to eq(6)
      end
    end
  end

  describe "solve_part_2" do
    describe "file-1" do
      before do
        @solver = Solver.new("test-file-3.txt")
      end

      it "finds ZZZ in 6 steps" do
        expect(@solver.solve_part_2).to eq(6)
      end
    end
  end

  describe "get_next_z_node" do
    it "goes to the next node ending in z for the current instruction" do
      solver = Solver.new("test-file-3.txt")
      first_node = solver.starting_points.first

      expect(solver.get_next_z_node(first_node, 0)).to eq(
        {
          steps: 2,
          checkpoint_node: solver.instructions["11Z"],
        },
      )
    end

    it "increments the provided count" do
      solver = Solver.new("test-file-3.txt")
      first_node = solver.starting_points.first

      expect(solver.get_next_z_node(first_node, 4)).to eq(
        {
          steps: 6,
          checkpoint_node: solver.instructions["11Z"],
        },
      )
    end
  end

  describe "initialize" do
    it "gets a set of left and right directions" do
      expect(Solver.new("test-file-1.txt").directions).to eq(%w[R L])
      expect(Solver.new("test-file-2.txt").directions).to eq(%w[L L R])
    end

    it "instantiates an Instruction for each line" do
      aaa_instructions = double("aaa_instructions", source: "ABC")
      bbb_instructions = double("bbb_instructions", source: "BBB")
      nondescript_instructions = double("xxx_instructions", source: "XXX")
      expect(Instruction).to receive(:new).with(source: "AAA", left: "BBB", right: "CCC").and_return(aaa_instructions)
      expect(Instruction).to receive(:new).with(source: "BBB", left: "DDD", right: "EEE").and_return(bbb_instructions)
      expect(Instruction).to receive(:new).with(source: "CCC", left: "ZZZ", right: "GGG").and_return(nondescript_instructions)
      expect(Instruction).to receive(:new).with(source: "DDD", left: "DDD", right: "DDD").and_return(nondescript_instructions)
      expect(Instruction).to receive(:new).with(source: "EEE", left: "EEE", right: "EEE").and_return(nondescript_instructions)
      expect(Instruction).to receive(:new).with(source: "GGG", left: "GGG", right: "GGG").and_return(nondescript_instructions)
      expect(Instruction).to receive(:new).with(source: "ZZZ", left: "ZZZ", right: "ZZZ").and_return(nondescript_instructions)

      solver = Solver.new("test-file-1.txt")

      expect(solver.instructions["AAA"]).to eq(aaa_instructions)
    end
  end
end
