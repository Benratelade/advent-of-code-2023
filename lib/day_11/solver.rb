# frozen_string_literal: true

require_relative "galaxy_map"

class Solver
  attr_accessor :galaxy_map

  def initialize(file)
    lines = []

    File.readlines(file).each do |line|
      lines << line.strip.chars
    end

    @galaxy_map = GalaxyMap.new(lines)
  end

  def solve_part_1
    @galaxy_map.galaxies.combination(2).sum do |galaxies_tuple|
      Galaxy.measure_distance(galaxies_tuple)
    end
  end
end