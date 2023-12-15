# frozen_string_literal: true

class Galaxy
  attr_accessor :y_coord, :x_coord

  def initialize(y_coord:, x_coord:)
    @x_coord = x_coord
    @y_coord = y_coord
  end

  def self.measure_distance(galaxy_tuple)
    galaxy_1, galaxy_2 = *galaxy_tuple

    (galaxy_1.x_coord - galaxy_2.x_coord).abs + (galaxy_1.y_coord - galaxy_2.y_coord).abs
  end
end
