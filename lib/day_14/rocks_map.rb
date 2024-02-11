# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
class RocksMap
  attr_accessor :geography, :initial_configuration

  def initialize(string)
    @geography = []

    string.split("\n").each do |row|
      @geography << row.chars
    end

    @initial_configuration = Marshal.load(Marshal.dump(@geography))
  end

  def reset
    @geography = @initial_configuration

    self
  end

  def tilt(direction)
    if %i[north south].include?(direction)
      offset = direction == :north ? -1 : 1
      range = if direction == :north
                (1..(@geography.length - 1)).to_a
              else
                (0..(@geography.length)).to_a.reverse
              end

      range.each do |row_index|
        next if @geography[row_index + offset].nil?

        row = @geography[row_index]
        row.each_with_index do |rock, rock_index|
          next unless rock == "O"
          next if @geography[row_index + offset][rock_index] == "O"
          next if @geography[row_index + offset][rock_index] == "#"

          @geography[row_index + offset][rock_index] = rock
          row[rock_index] = "."
        end
      end

    else
      offset = direction == :west ? -1 : 1
      range = if direction == :west
                (1..(@geography[0].length - 1)).to_a
              else
                (0...(@geography[0].length - 1)).to_a.reverse
              end

      @geography.each do |row|
        range.each do |rock_index|
          rock = row[rock_index]
          next unless rock == "O"
          next if row[rock_index + offset] == "O"
          next if row[rock_index + offset] == "#"

          row[rock_index + offset] = rock
          row[rock_index] = "."
        end
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

  def spin_cycle
    %i[north west south east].each do |direction|
      tilt_all_the_way(direction)
    end

    self
  end
end
