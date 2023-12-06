# frozen_string_literal: true

require "day_5/solver"
require "pry"

RSpec.describe Solver do
  describe "Solver" do
    before do
      @file = File.open("test-file.txt", "w") do |file|
        file << <<~CONTENT
          seeds: 79 14 55 13

          seed-to-soil map:
          50 98 2
          52 50 48

          soil-to-fertilizer map:
          0 15 37
          37 52 2
          39 0 15

          fertilizer-to-water map:
          49 53 8
          0 11 42
          42 0 7
          57 7 4

          water-to-light map:
          88 18 7
          18 25 70

          light-to-temperature map:
          45 77 23
          81 45 19
          68 64 13

          temperature-to-humidity map:
          0 69 1
          1 0 69

          humidity-to-location map:
          60 56 37
          56 93 4
        CONTENT
      end
      @solver = Solver.new("test-file.txt")
    end

    after do
      File.delete("test-file.txt")
    end

    describe ".solve_part_1" do
      it "returns the right location" do
        expect(@solver.solve_part_1).to eq(35)
      end
    end

    describe ".solve_part_2" do
      it "returns the right location" do
        expect(@solver.solve_part_2).to eq(46)
      end
    end

    describe ".seeds" do
      it "gets the seeds into an array" do
        expect(@solver.seeds).to eq([79, 14, 55, 13])
      end
    end

    describe ".get_location" do
      it "jumps through hoops to get the location for a seed" do
        expect(@solver.get_location(79)).to eq(82)
        expect(@solver.get_location(14)).to eq(43)
        expect(@solver.get_location(55)).to eq(86)
        expect(@solver.get_location(13)).to eq(35)
      end
    end

    describe ".hop" do
      it "hops to the next almanach item" do
        expect(@solver.hop(79, 0)).to eq(81)
      end
    end

    describe "mappings" do
      it "extracts the mappings from the file" do
        expect(@solver.mappings.keys).to eq(
          %w[
            seed-to-soil
            soil-to-fertilizer
            fertilizer-to-water
            water-to-light
            light-to-temperature
            temperature-to-humidity
            humidity-to-location
          ],
        )
      end

      it "gets the right mappings inside the right mappings" do
        expect(@solver.mappings["seed-to-soil"][98]).to eq(50)
        expect(@solver.mappings["water-to-light"][25]).to eq(18)
      end
    end
  end

  describe "Mapping" do
    describe "[]" do
      it "returns the value for a known mapping" do
        mapping = Solver::Mapping.new
        mapping.ranges << Solver::Mapping.map_from_ranges(source_start: 53, destination_start: 49, length: 8)

        expect(mapping[53]).to eq(49)
      end

      it "returns the provided value if it's not in the mapping" do
        mapping = Solver::Mapping.new
        mapping.ranges << Solver::Mapping.map_from_ranges(source_start: 53, destination_start: 49, length: 8)

        expect(mapping[32]).to eq(32)
      end
    end

    describe ".map_from_ranges" do
      it "creates a map from the range" do
        ranger_1 = Solver::Mapping.map_from_ranges(
          source_start: 53,
          destination_start: 49,
          length: 8,
        )
        expect(ranger_1.offset).to eq(-4)
        expect(ranger_1.source_start).to eq(53)
        expect(ranger_1.source_end).to eq(60)

        ranger_2 = Solver::Mapping.map_from_ranges(
          source_start: 49,
          destination_start: 53,
          length: 8,
        )
        expect(ranger_2.offset).to eq(4)
        expect(ranger_2.source_start).to eq(49)
        expect(ranger_2.source_end).to eq(56)
      end
    end
  end
end
