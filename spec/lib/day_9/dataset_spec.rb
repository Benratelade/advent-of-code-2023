# frozen_string_literal: true

require "day_9/dataset"
require "pry"

RSpec.describe Dataset do
  describe ".next_sequence" do
    it "builds the next sequence by calculating the difference between each element" do
      expect(Dataset.next_sequence([0, 3, 6, 9, 12, 15])).to eq([3, 3, 3, 3, 3])
      expect(Dataset.next_sequence([1, 3, 6, 10, 15, 21])).to eq([2, 3, 4, 5, 6])
      expect(Dataset.next_sequence([10, 13, 16, 21, 30, 45])).to eq([3, 3, 5, 9, 15])
    end
  end

  describe "#generate_sequences" do
    it "generates sequences until the differences are all 0" do
      dataset = Dataset.new([0, 3, 6, 9, 12, 15])
      expect(dataset.sequences).to eq(
        [
          [0, 3, 6, 9, 12, 15],
          [3, 3, 3, 3, 3],
          [0, 0, 0, 0],
        ],
      )
    end
  end

  describe "#get_next_prediction" do
    it "works out the next prediction by working its way up the sequences" do
      first_dataset = Dataset.new([0, 3, 6, 9, 12, 15])
      expect(first_dataset.get_next_prediction).to eq(18)

      second_dataset = Dataset.new([1, 3, 6, 10, 15, 21])
      expect(second_dataset.get_next_prediction).to eq(28)

      third_dataset = Dataset.new([10, 13, 16, 21, 30, 45])
      expect(third_dataset.get_next_prediction).to eq(68)
    end
  end

  describe "#get_previous_prediction" do
    it "works out the previous prediction by working its way up the sequences" do
      third_dataset = Dataset.new([10, 13, 16, 21, 30, 45])
      expect(third_dataset.get_previous_prediction).to eq(5)
    end
  end
end
