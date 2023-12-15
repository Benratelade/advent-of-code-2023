# frozen_string_literal: true

require "day_11/galaxy"
require "pry"

RSpec.describe Galaxy do
  describe ".initialize" do
    it "sets the x and y coordinates" do
      galaxy = Galaxy.new(y_coord: 5, x_coord: 3)
      expect(galaxy.x_coord).to eq(3)
      expect(galaxy.y_coord).to eq(5)
    end
  end

  describe ".measure_distance" do
    it "2 galaxies with the same coordinates have a distance of 0" do
      galaxy_1 = Galaxy.new(y_coord: 5, x_coord: 3)
      galaxy_2 = Galaxy.new(y_coord: 5, x_coord: 3)

      expect(Galaxy.measure_distance([galaxy_1, galaxy_2])).to eq(0)
    end

    it "uses the coordinates to measure distance" do
      galaxy_1 = Galaxy.new(y_coord: 6, x_coord: 1)
      galaxy_2 = Galaxy.new(y_coord: 11, x_coord: 5)

      expect(Galaxy.measure_distance([galaxy_1, galaxy_2])).to eq(9)

      galaxy_1 = Galaxy.new(y_coord: 0, x_coord: 4)
      galaxy_2 = Galaxy.new(y_coord: 10, x_coord: 9)

      expect(Galaxy.measure_distance([galaxy_1, galaxy_2])).to eq(15)
    end
  end
end
