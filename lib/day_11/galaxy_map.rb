# frozen_string_literal: true

require_relative "galaxy"

class GalaxyMap
  attr_accessor :galaxies

  def initialize(array)
    expanded_universe = GalaxyMap.correct_for_expansion(array)
    @galaxies = []

    expanded_universe.each_with_index do |row, y_coord|
      row.each_with_index do |tile, x_coord|
        @galaxies << Galaxy.new(y_coord: y_coord, x_coord: x_coord) if tile == "#"
      end
    end
  end

  def self.correct_for_expansion(array)
    expanded_universe = []

    array.each do |row|
      expanded_universe << row.dup
      expanded_universe << row.dup if row.all? { |tile| tile == "." }
    end

    columns_to_expand = []
    (0..array[0].length).each do |x_index|
      columns_to_expand << x_index if array.all? { |line| line[x_index] == "." }
    end

    columns_to_expand.reverse.each do |x_index|
      expanded_universe.each do |row|
        row.insert(x_index, ".")
      end
    end

    expanded_universe
  end
end
