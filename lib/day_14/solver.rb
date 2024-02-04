# frozen_string_literal: true

require_relative "rocks_map"
class Solver
  def initialize(file)
    @rocks_map = RocksMap.new(File.read(file))
  end

  def solve_part_1
    @rocks_map.tilt_all_the_way(:north)

    total = 0
    @rocks_map.geography.each_with_index do |row, index|
      total += row.sum { |rock| rock == "O" ? 1 : 0 } * (@rocks_map.geography.length - index)
    end

    total
  end
end
