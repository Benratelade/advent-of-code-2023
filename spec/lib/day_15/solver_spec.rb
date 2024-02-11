# frozen_string_literal: true

require "day_15/solver"
require "pry"

RSpec.describe Solver do
  before do
    File.open("test-file.txt", "w") do |file|
      file << <<~FILE_CONTENT
        rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
      FILE_CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".initialize" do
    before do
      allow(Operation).to receive(:new)
    end

    it "hashes each step" do
      expect(Hasher).to receive(:hash_all).with(
        ["rn=1", "cm-", "qp=3", "cm=2", "qp-", "pc=4", "ot=9", "ab=5", "pc-", "pc=6", "ot=7"],
      )

      Solver.new("test-file.txt")
    end

    it "instantiates an Operation for each step" do
      expect(Operation).to receive(:new).with("rn=1")
      expect(Operation).to receive(:new).with("cm-")
      expect(Operation).to receive(:new).with("qp=3")
      expect(Operation).to receive(:new).with("cm=2")
      expect(Operation).to receive(:new).with("qp-")
      expect(Operation).to receive(:new).with("pc=4")
      expect(Operation).to receive(:new).with("ot=9")
      expect(Operation).to receive(:new).with("ab=5")
      expect(Operation).to receive(:new).with("pc-")
      expect(Operation).to receive(:new).with("ot=7")

      Solver.new("test-file.txt")
    end
  end

  describe "#solve_part_1" do
    it "calculates the answer to part 1" do
      solver = Solver.new("test-file.txt")

      expect(solver.solve_part_1).to eq(1320)
    end
  end

  describe "#solve_part_2" do
    it "calculates the answer to part 2" do
      solver = Solver.new("test-file.txt")

      expect(solver.solve_part_2).to eq(145)
    end
  end
end
