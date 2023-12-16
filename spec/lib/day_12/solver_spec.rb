# frozen_string_literal: true

require "day_12/solver"
require "pry"

RSpec.describe Solver do
  before do
    File.open("test-file.txt", "w") do |file|
      file << <<~FILE_CONTENT
        ???.### 1,1,3
        .??..??...?##. 1,1,3
        ?#?#?#?#?#?#?#? 1,3,1,6
        ????.#...#... 4,1,1
        ????.######..#####. 1,6,5
        ?###???????? 3,2,1
      FILE_CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".initialize" do
    it "instantiates a ConditionRecord per line" do
      expect(ConditionRecord).to receive(:new).with("???.### 1,1,3")
      expect(ConditionRecord).to receive(:new).with(".??..??...?##. 1,1,3")
      expect(ConditionRecord).to receive(:new).with("?#?#?#?#?#?#?#? 1,3,1,6")
      expect(ConditionRecord).to receive(:new).with("????.#...#... 4,1,1")
      expect(ConditionRecord).to receive(:new).with("????.######..#####. 1,6,5")
      expect(ConditionRecord).to receive(:new).with("?###???????? 3,2,1")

      Solver.new("test-file.txt")
    end

    it "saves condition records in an instance variable" do
      solver = Solver.new("test-file.txt")
      expect(solver.condition_records.length).to eq(6)
    end
  end

  describe "#solve_part_1" do
    it "returns the sum of possible combinations of broken parts" do
      solver = Solver.new("test-file.txt")

      expect(solver.solve_part_1).to eq(21)
    end
  end
end
