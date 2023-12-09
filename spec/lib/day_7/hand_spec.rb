# frozen_string_literal: true

require "day_7/hand"
require "pry"
require "pry-nav"

RSpec.describe Hand do
  it "allows comparing 2 hands that are different types" do
    hand_1 = Hand.new(cards: %w[3 2 T 3 K], bid: 765)
    hand_2 = Hand.new(cards: %w[T 5 5 J 5], bid: 684)

    expect(hand_1 > hand_2).to be(false)
    expect(hand_2 > hand_1).to be(true)
    expect(hand_2 == hand_1).to be(false)
  end

  it "allows comparing 2 hands that are the same type" do
    hand_1 = Hand.new(cards: %w[K K 6 7 7], bid: 28)
    hand_2 = Hand.new(cards: %w[K T J J T], bid: 220)

    expect(hand_1 > hand_2).to be(true)
    expect(hand_2 > hand_1).to be(false)
  end

  it "sorts things in place if it needs to" do
    hand_1 = Hand.new(cards: %w[7 A 3 6 6], bid: 28, mode: :part_2)
    hand_2 = Hand.new(cards: %w[4 3 8 4 3], bid: 220, mode: :part_2)
    array = [hand_1, hand_2]
    array.sort!

    expect(array).to eq([hand_1, hand_2])

    array = [hand_2, hand_1]
    array.sort!

    expect(array).to eq([hand_1, hand_2])
  end

  it "allows setting the mode to part_2" do
    hand_1 = Hand.new(cards: %w[K K 6 7 7], bid: 28)
    expect(hand_1.mode).to eq(:part_1)

    hand_1.mode = :part_2
    expect(hand_1.mode).to eq(:part_2)
  end

  describe "#type" do
    it "returns the correct type for a hand based on its cards" do
      expect(Hand.new(cards: %w[3 2 T 3 K], bid: 0).type).to eq("one_pair")
      expect(Hand.new(cards: %w[T 5 5 J 5], bid: 0).type).to eq("three_of_a_kind")
      expect(Hand.new(cards: %w[K K 6 7 7], bid: 0).type).to eq("two_pairs")
      expect(Hand.new(cards: %w[K T J J T], bid: 0).type).to eq("two_pairs")
      expect(Hand.new(cards: %w[Q Q Q J A], bid: 0).type).to eq("three_of_a_kind")
    end

    describe "mode is :part_2" do
      it "returns the correct type for a hand based on its cards, replacing J for something better" do
        expect(Hand.new(cards: %w[3 2 T 3 K], bid: 0, mode: :part_2).type).to eq("one_pair")
        expect(Hand.new(cards: %w[T 5 5 J 5], bid: 0, mode: :part_2).type).to eq("four_of_a_kind")
        expect(Hand.new(cards: %w[K K 6 7 7], bid: 0, mode: :part_2).type).to eq("two_pairs")
        expect(Hand.new(cards: %w[K T J J T], bid: 0, mode: :part_2).type).to eq("four_of_a_kind")
        expect(Hand.new(cards: %w[Q Q Q J A], bid: 0, mode: :part_2).type).to eq("four_of_a_kind")
      end
    end
  end

  describe "#cards_count" do
    it "counts the number of cards in a hand" do
      expect(Hand.new(cards: %w[Q Q Q J A], bid: 0).cards_count).to eq(
        {
          "Q" => 3,
          "J" => 1,
          "A" => 1,
        },
      )
    end
  end

  describe ".card_values" do
    it "returns a hash with an arbitraty value for each card" do
      expect(Hand.card_values).to eq(
        {
          "2" => 1,
          "3" => 2,
          "4" => 3,
          "5" => 4,
          "6" => 5,
          "7" => 6,
          "8" => 7,
          "9" => 8,
          "T" => 9,
          "J" => 10,
          "Q" => 11,
          "K" => 12,
          "A" => 13,
        },
      )
    end
  end

  describe ".card_values_part_2" do
    it "returns a hash with an arbitraty value for each card" do
      expect(Hand.card_values).to eq(
        {
          "2" => 1,
          "3" => 2,
          "4" => 3,
          "5" => 4,
          "6" => 5,
          "7" => 6,
          "8" => 7,
          "9" => 8,
          "T" => 9,
          "J" => 10,
          "Q" => 11,
          "K" => 12,
          "A" => 13,
        },
      )
    end
  end
end
