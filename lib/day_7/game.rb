# frozen_string_literal: true

class Game
  attr_accessor :hands

  def initialize(hands:)
    @hands = hands
  end
end
