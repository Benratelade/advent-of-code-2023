# frozen_string_literal: true

class Solver
  attr_accessor :numbers, :matrix, :stars

  Number = Data.define(:value, :line_index, :start_index, :end_index)
  Star = Data.define(:line_index, :start_index, :end_index, :parts)

  def initialize
    @numbers = []
    @parts = Set.new
    @matrix = []
    @stars = []
    @gears = Set.new
  end

  def process_file(file)
    File.readlines(file).each_with_index do |line, index|
      @matrix << Solver.to_matrix(line.strip)
      get_numbers_in_line(line, index)
      get_stars_in_line(line, index)
    end

    @numbers.each do |number|
      @parts << number if part?(number)
    end

    @stars.each do |star|
      @gears << star if gear?(star)
    end

    [@parts.sum(&:value), @gears.sum { |gear| gear.parts.to_a[0].value * gear.parts.to_a[1].value }]
  end

  def get_numbers_in_line(line, line_index)
    # this is bonkers. To get each Matchdata, one must trick Ruby to call
    # :scan and .map on each result in the same operation
    match_data = line.to_enum(:scan, /(\d+)/).map { Regexp.last_match }
    match_data.each do |match|
      @numbers << Number.new(
        value: match[0].to_i,
        line_index: line_index,
        start_index: match.begin(0),
        end_index: match.end(0) - 1,
      )
    end
  end

  def part?(number)
    adjacent_positions_for(number).any? do |position|
      @matrix[position[0]][position[1]].match?(%r{[*+\#$=%\-/@&]})
    end
  end

  def gear?(star)
    surrounding_parts = Set.new

    adjacent_positions_for(star).each do |position|
      @parts.each do |part|
        next unless part.line_index == position[0]

        if (part.start_index..part.end_index).any? { |x_coord| x_coord == position[1] }
          surrounding_parts << part
          star.parts << part
        end
      end
    end

    # binding.pry if surrounding_parts.count==2

    surrounding_parts.count == 2
  end

  def adjacent_positions_for(number)
    positions = []
    previous_line_index = number.line_index.zero? ? nil : number.line_index - 1
    next_line_index = number.line_index == (@matrix.length - 1) ? nil : number.line_index + 1
    left_boundary = number.start_index.zero? ? 0 : number.start_index - 1
    right_boundary = number.end_index == (@matrix[0].length - 1) ? number.end_index : number.end_index + 1

    if previous_line_index
      (left_boundary..right_boundary).each do |x_coord|
        positions << [previous_line_index, x_coord]
      end
    end
    positions << [number.line_index, left_boundary] unless left_boundary == number.start_index
    positions << [number.line_index, right_boundary] unless right_boundary == number.end_index
    (left_boundary..right_boundary).each { |x_coord| positions << [next_line_index, x_coord] } if next_line_index

    positions
  end

  def get_stars_in_line(line, line_index)
    match_data = line.to_enum(:scan, /(\*)/).map { Regexp.last_match }
    match_data.each do |match|
      @stars << Star.new(
        line_index: line_index,
        start_index: match.begin(0),
        end_index: match.begin(0),
        parts: Set.new,
      )
    end
  end

  def self.to_matrix(line)
    line.chars
  end
end
