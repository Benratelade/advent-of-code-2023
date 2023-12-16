# frozen_string_literal: true

class SpringsList
  attr_accessor :springs, :unknown_springs

  def initialize(characters)
    @springs = characters

    set_unknown_springs
  end

  def set_unknown_springs
    @unknown_springs = []

    @springs.each_with_index do |spring, index|
      @unknown_springs << index if spring == "?"
    end
  end

  def all_possible_solutions
    solutions = []

    [".", "#"].repeated_permutation(@unknown_springs.length).each do |permutation|
      new_permutation = @springs.dup
      permutation.each do |character|
        new_permutation[new_permutation.index("?")] = character
      end
      solutions << new_permutation
    end

    solutions
  end
end
