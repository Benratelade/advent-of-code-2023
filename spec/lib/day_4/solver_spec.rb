# frozen_string_literal: true

require "day_4/solver"
require "pry"

RSpec.describe Solver do
  before do
    @file = File.open("test-file.txt", "w") do |file|
      file << <<~CONTENT
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
      CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end

  describe ".process_line" do
    it "extracts an ID from a line" do
      card = Solver.process_line("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
      expect(card.id).to eq(1)
    end

    it "extracts winning numbers into a data structure" do
      card = Solver.process_line("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
      expect(card.winning_numbers).to eq([41, 48, 83, 86, 17])
    end

    it "extracts your own numbers into a data structure" do
      card = Solver.process_line("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
      expect(card.own_numbers).to eq([83, 86, 6, 31, 17, 9, 48, 53])
    end
  end

  describe ".solve_part_1" do
    it "creates a Card for each line" do
      expect(Solver::Card).to receive(:new).with(
        id: 1,
        winning_numbers: [41, 48, 83, 86, 17],
        own_numbers: [83, 86, 6, 31, 17, 9, 48, 53],
      )
      expect(Solver::Card).to receive(:new).with(
        id: 2,
        winning_numbers: [13, 32, 20, 16, 61],
        own_numbers: [61, 30, 68, 82, 17, 32, 24, 19],
      )
      expect(Solver::Card).to receive(:new).with(
        id: 3,
        winning_numbers: [1, 21, 53, 59, 44],
        own_numbers: [69, 82, 63, 72, 16, 21, 14, 1],
      )
      expect(Solver::Card).to receive(:new).with(
        id: 4,
        winning_numbers: [41, 92, 73, 84, 69],
        own_numbers: [59, 84, 76, 51, 58, 5, 54, 83],
      )
      expect(Solver::Card).to receive(:new).with(
        id: 5,
        winning_numbers: [87, 83, 26, 28, 32],
        own_numbers: [88, 30, 70, 12, 93, 22, 82, 36],
      )
      expect(Solver::Card).to receive(:new).with(
        id: 6,
        winning_numbers: [31, 18, 13, 56, 72],
        own_numbers: [74, 77, 10, 23, 35, 67, 36, 11],
      )

      Solver.solve_part_1("test-file.txt")
    end

    it "sums all the points in the cards" do
      expect(Solver.solve_part_1("test-file.txt")).to eq(13)
    end
  end

  describe ".solve_part_2" do
    it "counts all the cards and the cards won by the cards by the cards by the cards by the cards by the cards" do
      expect(Solver.solve_part_2("test-file.txt")).to eq(30)
    end
  end

  describe "Card" do
    before do
      @card_1 = Solver.process_line("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
      @card_2 = Solver.process_line("Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19")
      @card_3 = Solver.process_line("Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1")
      @card_4 = Solver.process_line("Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83")
      @card_5 = Solver.process_line("Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36")
    end

    describe "#numbers_that_won" do
      it "counts how many numbers are winning on a card" do
        expect(@card_1.numbers_that_won).to eq([48, 83, 86, 17])
        expect(@card_2.numbers_that_won).to eq([32, 61])
        expect(@card_3.numbers_that_won).to eq([1, 21])
        expect(@card_4.numbers_that_won).to eq([84])
        expect(@card_5.numbers_that_won).to eq([])
      end
    end

    describe "#score" do
      it "returns a score for a card based on how many numbers won" do
        expect(@card_1.score).to eq(8)
        expect(@card_2.score).to eq(2)
        expect(@card_3.score).to eq(2)
        expect(@card_4.score).to eq(1)
        expect(@card_5.score).to eq(0)
      end
    end

    describe "#prize_cards_ids" do
      it "returns a list of IDs of cards won by this particular card" do
        expect(@card_1.prize_cards_ids).to eq([2, 3, 4, 5])
        expect(@card_2.prize_cards_ids).to eq([3, 4])
        expect(@card_3.prize_cards_ids).to eq([4, 5])
        expect(@card_4.prize_cards_ids).to eq([5])
      end
    end
  end
end
