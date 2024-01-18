# frozen_string_literal: true

class Valley
  attr_accessor :geography

  def initialize(valley_map)
    @geography = []

    valley_map.split("\n").each do |line|
      @geography << line.chars
    end
  end

  def line_of_reflection
    {
      vertical: find_vertical_line_of_reflection,
      horizontal: find_horizontal_line_of_reflection,
    }
  end

  def find_vertical_line_of_reflection
    line_of_reflection_location = nil
    (1...@geography.first.length).each do |index|
      before_middle = (index <= (@geography.first.length / 2))
      reflection_length = before_middle ? (1..index).size : (index...@geography.first.length).size

      line_of_reflection_location = [index, index + 1] if @geography.all? do |row|
        row.slice((index - reflection_length), reflection_length) == row.slice(index, reflection_length).reverse
      end

      break if line_of_reflection_location
    end

    line_of_reflection_location
  end

  def find_horizontal_line_of_reflection
    line_of_reflection_location = nil
    (1...@geography.length).each do |index|
      before_middle = (index <= (@geography.length / 2))
      reflection_length = before_middle ? (1..index).size : (index...@geography.length).size

      reflection_top = @geography.slice((index - reflection_length), reflection_length)
      reflection_bottom = @geography.slice(index, reflection_length).reverse
      line_of_reflection_location = [index, index + 1] if reflection_top == reflection_bottom

      break if line_of_reflection_location
    end

    line_of_reflection_location
  end
end
