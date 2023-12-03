# frozen_string_literal: true

class Solver
  attr_accessor :numbers, :matrix

  Number = Data.define(:value, :line_index, :start_index, :end_index)

  def initialize
    @numbers = []
    @matrix = []
  end

  def process_file(file)
    File.readlines(file).each_with_index do |line, index|
      @matrix << Solver.to_matrix(line.strip)
      get_numbers_in_line(line, index)
    end

    total = 0

    @numbers.each do |number|
      total += number.value if has_adjacent_special_character(number)
    end

    total
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

  def has_adjacent_special_character(number)
    adjacent_positions_for(number).any? do |position|
      @matrix[position[0]][position[1]].match?(/[\*\+\#\$\=\%\-\/\@&]/)
    end
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

  def self.to_matrix(line)
    line.chars
  end
end
