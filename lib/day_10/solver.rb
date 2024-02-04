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
    @map.print_map
    length = @map.loop.length

    length.even? ? length / 2 : ((length - 1) / 2) + 1
  end

  def solve_part_2
    sum = 0
    clusters_within_loop = []

    @map.unused_clusters.each do |unused_cluster|
      within_loop = true
      unused_cluster.each do |node|
        next unless within_loop

        within_loop = @map.node_is_within_loop(node)
      end

      clusters_within_loop << unused_cluster if within_loop
      sum += unused_cluster.length if within_loop
    end

    sum
  end
end
