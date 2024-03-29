# frozen_string_literal: true

require "day_12/condition_record"
require "pry"

RSpec.describe ConditionRecord do
  describe ".initialize" do
    it "instantiates the necessary records from a line" do
      damaged_spring_record = double("damaged spring record")
      expect(DamagedSpringsRecord).to receive(:new).with([1, 1, 3]).and_return(damaged_spring_record)

      springs_list = double("springs list")
      expect(SpringsList).to receive(:new).with(
        ["?", "?", "?", ".", "#", "#", "#"],
        damaged_spring_record,
      ).and_return(springs_list)

      ConditionRecord.new("???.### 1,1,3")
    end
  end

  describe ".possible_solutions" do
    it "generates the list of solutions for which both springs_list and damaged_springs_record agree" do
      condition_record = ConditionRecord.new("???.### 1,1,3")
      expect(condition_record.possible_solutions.count).to eq(1)

      condition_record = ConditionRecord.new(".??..??...?##. 1,1,3")
      expect(condition_record.possible_solutions).to contain_exactly(
        [".", "#", ".", ".", ".", "#", ".", ".", ".", ".", "#", "#", "#", "."],
        [".", "#", ".", ".", ".", ".", "#", ".", ".", ".", "#", "#", "#", "."],
        [".", ".", "#", ".", ".", "#", ".", ".", ".", ".", "#", "#", "#", "."],
        [".", ".", "#", ".", ".", ".", "#", ".", ".", ".", "#", "#", "#", "."],
      )
    end

    describe "experiments for part 2" do
      it "generates the list of solutions for which both springs_list and damaged_springs_record agree for very long records" do
        condition_record = ConditionRecord.new(".??..??...?##. 1,1,3")
        expect(condition_record.possible_solutions.count).to eq(4)

        condition_record = ConditionRecord.new(".??..??...?##.?.??..??...?##. 1,1,3,1,1,3")
        expect(condition_record.possible_solutions.count).to eq(32)

        condition_record = ConditionRecord.new(".??..??...?##.?.??..??...?##.?.??..??...?##. 1,1,3,1,1,3,1,1,3")
        expect(condition_record.possible_solutions.count).to eq(256)
      end

      it "generates possible solutions for ?#?#?#?#?#?#?#? 1,3,1,6" do
        condition_record = ConditionRecord.new("?#?#?#?#?#?#?#? 1,3,1,6")
        expect(condition_record.possible_solutions.count).to eq(1)

        condition_record = ConditionRecord.new("?#?#?#?#?#?#?#???#?#?#?#?#?#?#? 1,3,1,6,1,3,1,6")
        expect(condition_record.possible_solutions.count).to eq(1)
      end

      it "generates possible solutions for ????.#...#... 4,1,1" do
        condition_record = ConditionRecord.new("????.#...#... 4,1,1")
        expect(condition_record.possible_solutions.count).to eq(1)

        condition_record = ConditionRecord.new("????.#...#...?????.#...#... 4,1,1,4,1,1")
        expect(condition_record.possible_solutions.count).to eq(2)

        condition_record = ConditionRecord.new("????.#...#...?????.#...#...?????.#...#... 4,1,1,4,1,1,4,1,1")
        expect(condition_record.possible_solutions.count).to eq(4)
      end

      it "generates possible solutions for ????.######..#####. 1,6,5" do
        condition_record = ConditionRecord.new("????.######..#####. 1,6,5")
        expect(condition_record.possible_solutions.count).to eq(4)

        condition_record = ConditionRecord.new("????.######..#####.?????.######..#####. 1,6,5,1,6,5")
        expect(condition_record.possible_solutions.count).to eq(20)

        condition_record = ConditionRecord.new("????.######..#####.?????.######..#####.?????.######..#####. 1,6,5,1,6,5,1,6,5")
        expect(condition_record.possible_solutions.count).to eq(100)

        # condition_record = ConditionRecord.new("????.######..#####.?????.######..#####.?????.######..#####.?????.######..#####. 1,6,5,1,6,5,1,6,5,1,6,5")
        # expect(condition_record.possible_solutions.count).to eq(500)
      end

      it "generates insane lists" do
        condition_record = ConditionRecord.new("?###???????? 3,2,1")
        expect(condition_record.possible_solutions.count).to eq(10)

        # condition_record = ConditionRecord.new("?###??????????###???????? 3,2,1,3,2,1")
        # expect(condition_record.possible_solutions.count).to eq(150)
      end
    end
  end

  describe ".last_group_never_changes" do
    it "returns true if the last group is always the same" do
      condition_record = ConditionRecord.new("???.### 1,1,3")

      expect(condition_record.last_group_never_changes).to be(true)
    end

    it "returns false if the last group changes in the possible solutions" do
      condition_record = ConditionRecord.new("?###???????? 3,2,1")

      expect(condition_record.last_group_never_changes).to be(false)
    end
  end

  describe ".possible_solutions_part_2" do
    it "only counts the number of solutions, based on extended solutions" do
      condition_record = ConditionRecord.new("???.### 1,1,3")
      expect(condition_record.possible_solutions_part_2).to eq(1)

      condition_record = ConditionRecord.new(".??..??...?##. 1,1,3")
      expect(condition_record.possible_solutions_part_2).to eq(16_384)

      condition_record = ConditionRecord.new("???????#??.???#? 2,2,4,3")
      expect(condition_record.possible_solutions_part_2).to eq(1250)

      condition_record = ConditionRecord.new("?#?#?#?#?#?#?#? 1,3,1,6")
      expect(condition_record.possible_solutions_part_2).to eq(1)

      condition_record = ConditionRecord.new("????.#...#... 4,1,1")
      expect(condition_record.possible_solutions_part_2).to eq(16)

      condition_record = ConditionRecord.new("????.######..#####. 1,6,5")
      expect(condition_record.possible_solutions_part_2).to eq(2500)

      condition_record = ConditionRecord.new("?###???????? 3,2,1")
      expect(condition_record.possible_solutions_part_2).to eq(506_250)
    end
  end
end
