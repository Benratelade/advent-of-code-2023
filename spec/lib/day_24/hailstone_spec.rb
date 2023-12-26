# frozen_string_literal: true

require "day_24/hailstone"
require "pry"

RSpec.describe Hailstone do
  describe "#initialize" do
    it "sets the x, y and z positions" do
      hailstone = Hailstone.new(position: [19, 13, 30], velocity: [-2, 1, -2])

      expect(hailstone.starting_x).to eq(19)
      expect(hailstone.starting_y).to eq(13)
      expect(hailstone.starting_z).to eq(30)
    end

    it "sets the velocity" do
      hailstone = Hailstone.new(position: [19, 13, 30], velocity: [-2, 1, -2])

      expect(hailstone.x_velocity).to eq(-2)
      expect(hailstone.y_velocity).to eq(1)
      expect(hailstone.z_velocity).to eq(-2)
    end
  end

  describe ".coordinates_after_n_steps" do
    it "advances the hailstone by the provided number of steps" do
      hailstone = Hailstone.new(position: [19, 13, 30], velocity: [-2, 1, -2])

      expect(hailstone.coordinates_after_n_steps(1)).to eq([17, 14, 28])
      expect(hailstone.coordinates_after_n_steps(2)).to eq([15, 15, 26])
    end
  end

  describe ".slope" do
    it "returns the leading coefficient of the function describing the movement on a plane" do
      hailstone = Hailstone.new(position: [19, 13, 30], velocity: [-2, 1, -2])

      expect(hailstone.slope).to eq(-0.5)
    end
  end

  describe ".y_coefficient" do
    it "returns the y_coefficient for the movement on a plane" do
      hailstone = Hailstone.new(position: [19, 13, 30], velocity: [-2, 1, -2])

      expect(hailstone.y_coefficient).to eq(22.5)
    end
  end

  describe ".hailstone_intersection" do
    it "tells us where and when a hailstone will intersect with this hailstone" do
      hailstone_1 = Hailstone.new(position: [19, 13, 30], velocity: [-2, 1, -2])
      hailstone_2 = Hailstone.new(position: [18, 19, 22], velocity: [-1, -1, -2])

      result = hailstone_1.hailstone_intesection(hailstone_2)
      expect(result[:x_intersection]).to be_within(0.000001).of(14.333333)
      expect(result[:y_intersection]).to be_within(0.000001).of(15.333333)
      expect(result[:intersects]).to eq(:future)
    end

    it "tells us where and when a hailstone will intersect with this hailstone, but in the past" do
      hailstone_1 = Hailstone.new(position: [19, 13, 30], velocity: [-2, 1, -2])
      hailstone_2 = Hailstone.new(position: [20, 19, 15], velocity: [1, -5, -3])

      result = hailstone_1.hailstone_intesection(hailstone_2)
      expect(result[:x_intersection]).to be_within(0.000001).of(21.444444)
      expect(result[:y_intersection]).to be_within(0.000001).of(11.777777)
      expect(result[:intersects]).to eq(:past)
    end

    it "tells us where and when a hailstone will intersect with this hailstone, but in the past (again)" do
      hailstone_1 = Hailstone.new(position: [20, 25, 34], velocity: [-2, -2, -4])
      hailstone_2 = Hailstone.new(position: [20, 19, 15], velocity: [1, -5, -3])

      result = hailstone_1.hailstone_intesection(hailstone_2)
      expect(result[:x_intersection]).to be_within(0.000001).of(19.000000)
      expect(result[:y_intersection]).to be_within(0.000001).of(24.000000)
      expect(result[:intersects]).to eq(:past)
    end

    it "tells you when two hailstones will never intersect" do
      hailstone_1 = Hailstone.new(position: [18, 19, 22], velocity: [-1, -1, -2])
      hailstone_2 = Hailstone.new(position: [20, 25, 34], velocity: [-2, -2, -4])

      result = hailstone_1.hailstone_intesection(hailstone_2)
      expect(result[:x_intersection]).to be(nil)
      expect(result[:y_intersection]).to be(nil)
      expect(result[:intersects]).to eq(:never)
    end
  end

  describe ".coordinate_in_future?" do
    it "returns true if a coordinate is in the future for the hailstone" do
      hailstone = Hailstone.new(position: [20, 25, 34], velocity: [-2, -2, -4])

      expect(hailstone.coordinate_in_future?(19.0)).to be(true)
    end

    it "returns false if a coordinate is in the past for the hailstone" do
      hailstone = Hailstone.new(position: [20, 19, 15], velocity: [1, -5, -3])

      expect(hailstone.coordinate_in_future?(19.0)).to be(false)
    end
  end
end
