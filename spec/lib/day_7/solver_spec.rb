# frozen_string_literal: true

require "day_7/solver"
require "pry"

RSpec.describe Solver do
  before do
    @file = File.open("test-file.txt", "w") do |file|
      file << <<~CONTENT
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
      CONTENT
    end
    @solver = Solver.new("test-file.txt")
  end

  after do
    File.delete("test-file.txt")
  end

  describe "with mocks" do
    before do
      @game = double("game")
      allow(Game).to receive(:new).and_return(@game)
    end

    describe ".initialize" do
      it "creates a hand for each line in the input" do
        expect(Hand).to receive(:new).with(cards: %w[3 2 T 3 K], bid: 765, mode: :part_1)
        expect(Hand).to receive(:new).with(cards: %w[T 5 5 J 5], bid: 684, mode: :part_1)
        expect(Hand).to receive(:new).with(cards: %w[K K 6 7 7], bid: 28, mode: :part_1)
        expect(Hand).to receive(:new).with(cards: %w[K T J J T], bid: 220, mode: :part_1)
        expect(Hand).to receive(:new).with(cards: %w[Q Q Q J A], bid: 483, mode: :part_1)

        Solver.new("test-file.txt")
      end

      it "creates a solver that has a Game property, which is a game" do
        hand = double("hand")
        allow(Hand).to receive(:new).and_return(hand)
        expect(Game).to receive(:new).with(hands: [hand, hand, hand, hand, hand])

        @solver = Solver.new("test-file.txt")

        expect(@solver.game).to eq(@game)
      end
    end
  end

  describe "#solve_part_1" do
    it "returns the sum of total winnings" do
      expect(@solver.solve_part_1).to eq(6440)
    end
  end

  describe "#solve_part_2" do
    it "returns the sum of total winnings but only after swapping Jokers" do
      @solver = Solver.new("test-file.txt", :part_2)
      expect(@solver.solve_part_2).to eq(5905)
    end
  end
end
