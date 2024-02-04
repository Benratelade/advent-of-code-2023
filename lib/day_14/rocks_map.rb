# frozen_string_literal: true

class RocksMap
  attr_accessor :geography

  def initialize(string)
    @geography = []

    string.split("\n").each do |row|
      @geography << row.chars
    end
  end

  def tilt(_direction = :north)
    @geography.each_with_index do |row, row_index|
      next if row_index.zero?

      row.each_with_index do |rock, rock_index|
        next if rock == "#"
        next if rock == "."
        next if @geography[row_index - 1][rock_index] == "O"
        next if @geography[row_index - 1][rock_index] == "#"

        @geography[row_index - 1][rock_index] = rock
        row[rock_index] = "."
      end
    end

    self
  end

  def tilt_all_the_way(direction = :north)
    loop do
      before_tilt = Marshal.load(Marshal.dump(@geography))
      tilt(direction)

      break if before_tilt == @geography
    end

    self
  end
end
