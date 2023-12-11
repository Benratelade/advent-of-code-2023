# frozen_string_literal: true

require "day_9/solver"
require "pry"

RSpec.describe Solver do
  before do
    @file = File.open("test-file.txt", "w") do |file|
      file << <<~CONTENT
        0 3 6 9 12 15
        1 3 6 10 15 21
        10 13 16 21 30 45
      CONTENT
    end
    @solver = Solver.new("test-file.txt")
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".initialize" do
    it "creates a new Dataset for each row" do
      expect(Dataset).to receive(:new).with([0, 3, 6, 9, 12, 15])
      expect(Dataset).to receive(:new).with([1, 3, 6, 10, 15, 21])
      expect(Dataset).to receive(:new).with([10, 13, 16, 21, 30, 45])

      Solver.new("test-file.txt")
    end
  end

  describe ".solve_part_1" do
    it "brilliantly solves the part 1" do
      expect(@solver.solve_part_1).to eq(114)
    end
  end

  describe ".solve_part_2" do
    it "brilliantly solves the part 2" do
      expect(@solver.solve_part_2).to eq(2)
    end
  end
end
