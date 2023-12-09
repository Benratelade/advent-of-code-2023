# frozen_string_literal: true

require_relative "game"
require_relative "hand"

class Solver
  attr_accessor :game

  def initialize(file, mode = :part_1)
    hands = []
    File.readlines(file).each do |line|
      cards_string, bid_string = line.split
      cards = cards_string.chars
      bid = bid_string.to_i
      hands << Hand.new(cards: cards, bid: bid, mode: mode)
    end

    hands.sort!

    @game = Game.new(hands: hands)
  end

  def solve_part_1
    sum = 0
    @game.hands.each_with_index do |hand, index|
      sum += hand.bid * (index + 1)
    end

    sum
  end

  def solve_part_2
    sum = 0
    @game.hands.each_with_index do |hand, index|
      sum += hand.bid * (index + 1)
    end

    sum
  end
end
