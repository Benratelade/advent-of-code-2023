# frozen_string_literal: true

module Solver
  class Card
    attr_accessor :id, :winning_numbers, :own_numbers

    def initialize(id:, winning_numbers:, own_numbers:)
      @id = id
      @winning_numbers = winning_numbers
      @own_numbers = own_numbers
    end

    def numbers_that_won
      won = []

      @winning_numbers.each do |number|
        won << number if own_numbers.include?(number)
      end

      won
    end

    def score
      total = 0

      numbers_that_won.each_with_index do |_number, index|
        if index.zero?
          total = 1
        else
          total *= 2
        end
      end

      total
    end

    def prize_cards_ids
      ((id + 1)..(id + numbers_that_won.count)).to_a
    end
  end

  def self.solve_part_1(file)
    cards = []

    File.readlines(file).each do |line|
      cards << process_line(line)
    end

    cards.sum(&:score)
  end

  def self.solve_part_2(file)
    original_cards = []

    File.readlines(file).each do |line|
      original_cards << process_line(line)
    end

    all_cards = original_cards.dup

    all_cards.each do |card|
      card.prize_cards_ids.each do |id|
        all_cards << original_cards[id - 1]
      end
    end

    all_cards.count
  end

  def self.process_line(line)
    title = line.match(/Card\s+(\d+)/)
    winning_side, own_side = line[title.end(0) + 1, line.length].split("|")
    winning_numbers = winning_side.scan(/(\d+)/).map { |match| match[0].to_i }
    numbers_you_have = own_side.scan(/(\d+)/).map { |match| match[0].to_i }

    Card.new(
      id: title[1].to_i,
      winning_numbers: winning_numbers,
      own_numbers: numbers_you_have,
    )
  end
end
