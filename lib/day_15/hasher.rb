# frozen_string_literal: true

module Hasher
  def self.hash_all(steps)
    steps.map do |step|
      Hasher.apply_hash_algorithm(step)
    end
  end

  def self.apply_hash_algorithm(string)
    value = 0

    string.chars.each do |char|
      value += char.ord
      value *= 17
      value %= 256
    end

    value
  end
end
