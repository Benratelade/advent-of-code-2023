# frozen_string_literal: true

require_relative "valley"

class Solver
  def initialize(file)
    @valleys = []

    File.read(file).split(/^\n/).each do |valley_string|
      @valleys << Valley.new(valley_string)
    end
  end

  def solve_part_1
    total = 0
    @valleys.each do |valley|
      if valley.line_of_reflection[:horizontal]
        total += 100 * valley.line_of_reflection[:horizontal][0]
      elsif valley.line_of_reflection[:vertical]
        total += valley.line_of_reflection[:vertical][0]
      end
    end

    total
  end
end
