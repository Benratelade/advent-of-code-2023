# frozen_string_literal: true

class Hailstone
  attr_accessor :starting_x, :starting_y, :starting_z, :x_velocity, :y_velocity, :z_velocity

  def initialize(position:, velocity:)
    @starting_x = position[0]
    @starting_y = position[1]
    @starting_z = position[2]

    @x_velocity = velocity[0]
    @y_velocity = velocity[1]
    @z_velocity = velocity[2]
  end

  def coordinates_after_n_steps(steps)
    [
      @starting_x + (steps * @x_velocity),
      @starting_y + (steps * @y_velocity),
      @starting_z + (steps * @z_velocity),
    ]
  end

  def slope
    (coordinates_after_n_steps(1)[1] - @starting_y.to_f) / (coordinates_after_n_steps(1)[0] - @starting_x)
  end

  def y_coefficient
    # y = ax + b (b is unknown)
    # @starting_y = slope * @starting_x + b
    # b = @starting_y - (slope * @starting_x)
    @starting_y - (slope * @starting_x)
  end

  def hailstone_intesection(hailstone)
    divide_by = slope - hailstone.slope
    if divide_by.zero?
      return {
        x_intersection: nil,
        y_intersection: nil,
        intersects: :never,
      }
    end

    x_intersection = (hailstone.y_coefficient - y_coefficient) / divide_by
    y_intersection = (x_intersection * slope) + y_coefficient

    intersects = if coordinate_in_future?(x_intersection) && hailstone.coordinate_in_future?(x_intersection)
                   :future
                 else
                   :past
                 end

    {
      x_intersection: x_intersection,
      y_intersection: y_intersection,
      intersects: intersects,
    }
  end

  def coordinate_in_future?(x_coord)
    is_hailstone_travelling_right = (@starting_x + @x_velocity) >= @starting_x

    if is_hailstone_travelling_right
      x_coord >= @starting_x
    else
      x_coord <= @starting_x
    end
  end
end
