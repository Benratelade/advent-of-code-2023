# frozen_string_literal: true

class Hand
  include Comparable
  attr_accessor :cards, :bid, :mode

  def initialize(cards:, bid:, mode: :part_1)
    @cards = cards
    @bid = bid
    @mode = mode
  end

  def <=>(other)
    return TYPES[type] <=> TYPES[other.type] unless type == other.type

    cards.each_with_index do |card, index|
      next if card == other.cards[index]

      return Hand.card_values[card] <=> Hand.card_values[other.cards[index]] if mode == :part_1

      return Hand.card_values_part_2[card] <=> Hand.card_values_part_2[other.cards[index]]
    end
  end

  def type
    case cards_count.keys.length
    when 5
      "high_card"
    when 4
      "one_pair"
    when 3
      return "three_of_a_kind" if cards_count.values.max == 3

      "two_pairs"
    when 2
      return "four_of_a_kind" if cards_count.values.max == 4

      "full_house"
    when 1
      "five_of_a_kind"
    end
  end

  def cards_count
    hash = {}
    cards.each do |card|
      hash[card] ||= 0
      hash[card] = hash[card] + 1
    end

    if hash["J"] && mode == :part_2
      return hash if hash["J"] == 5

      hash["J"].times do |_count|
        sorted_values = hash.max(5) do |element_1, element_2|
          element_1[1] <=> element_2[1]
        end
        sorted_values.each do |pair|
          hash[pair[0]] = hash[pair[0]] += 1 unless hash[pair[0]] >= 4
        end
        hash["J"] = hash["J"] - 1
      end

      hash.delete("J")
    end

    hash
  end

  TYPES = {
    "high_card" => 1,
    "one_pair" => 2,
    "two_pairs" => 3,
    "three_of_a_kind" => 4,
    "full_house" => 5,
    "four_of_a_kind" => 6,
    "five_of_a_kind" => 7,
  }.freeze

  def self.card_values_part_2
    {
      "J" => 1,
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "T" => 10,
      "Q" => 11,
      "K" => 12,
      "A" => 13,
    }.freeze
  end

  def self.card_values
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
    }.freeze
  end
end
