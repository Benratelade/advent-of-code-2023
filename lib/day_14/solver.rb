# frozen_string_literal: true

require_relative "rocks_map"
class Solver
  def initialize(file)
    @rocks_map = RocksMap.new(File.read(file))
  end

  def solve_part_1
    @rocks_map.tilt_all_the_way(:north)

    calculate_load
  end

  def solve_part_2
    existing_patterns = {}
    matching_iteration = nil
    last_iteration = {}

    1000.times do |iteration|
      @rocks_map.spin_cycle
      number_of_spins = iteration + 1

      last_iteration = { number_of_spins => Marshal.load(Marshal.dump(@rocks_map.geography)) }
      matching_iteration = existing_patterns.filter { |_iteration, pattern| pattern == @rocks_map.geography }
      break if matching_iteration.any?

      existing_patterns[number_of_spins] = Marshal.load(Marshal.dump(@rocks_map.geography))
    end

    puts "The pattern repeats for the following number of spins #{matching_iteration.keys}" if matching_iteration

    @rocks_map.reset

    number_of_repeated_transformations = (1_000_000_000 - matching_iteration.first[0]) % (last_iteration.first[0] - matching_iteration.first[0])
    (matching_iteration.first[0] + number_of_repeated_transformations).times do |iteration|
      @rocks_map.spin_cycle
    end

    calculate_load
  end

  private

  def calculate_load
    total = 0
    @rocks_map.geography.each_with_index do |row, index|
      total += row.sum { |rock| rock == "O" ? 1 : 0 } * (@rocks_map.geography.length - index)
    end

    total
  end
end
