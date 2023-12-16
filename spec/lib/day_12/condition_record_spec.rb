# frozen_string_literal: true

require "day_12/condition_record"
require "pry"

RSpec.describe ConditionRecord do
  describe ".initialize" do
    it "instantiates the necessary records from a line" do
      springs_list = double("springs list")
      expect(SpringsList).to receive(:new).with(["?", "?", "?", ".", "#", "#", "#"]).and_return(springs_list)

      damaged_spring_record = double("damaged spring record")
      expect(DamagedSpringsRecord).to receive(:new).with([1, 1, 3]).and_return(damaged_spring_record)

      ConditionRecord.new("???.### 1,1,3")
    end
  end

  describe ".possible_solutions" do
    it "generates the list of solutions for which both springs_list and damaged_springs_record agree" do
      # condition_record = ConditionRecord.new("???.### 1,1,3")
      # expect(condition_record.possible_solutions.count).to eq(1)

      condition_record = ConditionRecord.new(".??..??...?##. 1,1,3")
      expect(condition_record.possible_solutions).to contain_exactly(
        [".", "#", ".", ".", ".", "#", ".", ".", ".", ".", "#", "#", "#", "."],
        [".", "#", ".", ".", ".", ".", "#", ".", ".", ".", "#", "#", "#", "."],
        [".", ".", "#", ".", ".", "#", ".", ".", ".", ".", "#", "#", "#", "."],
        [".", ".", "#", ".", ".", ".", "#", ".", ".", ".", "#", "#", "#", "."],
      )
    end
  end
end
