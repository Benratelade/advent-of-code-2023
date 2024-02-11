# frozen_string_literal: true

require_relative "hailstone"
class Solver
  attr_accessor :hailstones

  def initialize(file)
    @hailstones = []

    File.readlines(file).each do |line|
      position, velocity = line.split("@").map { |data| data.split(",").map(&:to_i) }
      @hailstones << Hailstone.new(position: position, velocity: velocity)
    end
  end

  def solve_part_1(interval = nil)
    interval ||= (200_000_000_000_000..400_000_000_000_000)
    sum = 0

    @hailstones.each_with_index do |hailstone, index|
      (index + 1..@hailstones.length - 1).each do |secondary_index|
        intersection = hailstone.hailstone_intesection(@hailstones[secondary_index])
        next unless intersection[:intersects] == :future &&
                    (interval.include?(intersection[:x_intersection]) &&
                    interval.include?(intersection[:y_intersection]))

        sum += 1
      end
    end

    sum
  end
end
