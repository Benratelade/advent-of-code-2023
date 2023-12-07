# frozen_string_literal: true

require "day_6/solver"
require "pry"

RSpec.describe Solver do
  describe "Solver" do
    before do
      @file = File.open("test-file.txt", "w") do |file|
        file << <<~CONTENT
          Time:      7  15   30
          Distance:  9  40  200
        CONTENT
      end
      @solver = Solver.new("test-file.txt")
    end

    after do
      File.delete("test-file.txt")
    end

    describe ".solve_part_1" do
      it "returns the produt of ways one can win all the races" do
        expect(@solver.solve_part_1).to eq(288)
      end
    end

    describe ".solve_part_2" do
      it "returns the numbers of ways one can win one very long race" do
        expect(@solver.solve_part_2).to eq(71_503)
      end
    end

    describe ".initialize" do
      it "creates a race object for each race" do
        expect(Race).to receive(:new).with(duration: 7, record: 9)
        expect(Race).to receive(:new).with(duration: 15, record: 40)
        expect(Race).to receive(:new).with(duration: 30, record: 200)

        Solver.new("test-file.txt")
      end

      it "creates a single race object for part 2" do
        expect(@solver.race.duration).to eq(71_530)
        expect(@solver.race.record).to eq(940_200)
      end
    end

    describe ".winning_strategies" do
      it "returns a list of strategies that beat the record for the race" do
        expect(Race.new(duration: 7, record: 9).winning_strategies).to eq(
          [
            {
              press_duration: 2,
              distance: 10,
            },
            {
              press_duration: 3,
              distance: 12,
            },
            {
              press_duration: 4,
              distance: 12,
            },
            {
              press_duration: 5,
              distance: 10,
            },
          ],
        )
      end
    end
  end
end
