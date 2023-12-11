# frozen_string_literal: true

require_relative "dataset"

class Solver
  attr_accessor :datasets

  def initialize(file)
    @datasets = []

    File.readlines(file).each do |line|
      @datasets << Dataset.new(
        line.scan(/(-?\d+)/)
        .map { |number| number[0].to_i },
      )
    end
  end

  def solve_part_1
    datasets.sum(&:get_next_prediction)
  end

  def solve_part_2
    datasets.sum(&:get_previous_prediction)
  end
end
