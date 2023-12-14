# frozen_string_literal: true

require_relative "pipe_map"

class Solver
  attr_accessor :map
  def initialize(file)
    lines = []

    File.readlines(file).each do |line|
      lines << line.strip.chars
    end

    @map = PipeMap.new(lines)
  end

  def solve_part_1
    length = @map.loop.length

    length.even? ? length / 2 : (length - 1) / 2 + 1
  end

  def solve_part_2
    
  end
end
