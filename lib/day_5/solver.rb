# frozen_string_literal: true

class Solver
  class Mapping
    attr_accessor :ranges

    Ranger = Data.define(
      :source_start,
      :source_end,
      :destination_start,
      :length,
      :offset,
    )
    def initialize
      @ranges = []
    end

    def [](index)
      @ranges.each do |range|
        return index + range.offset if index >= range.source_start && index <= range.source_end
      end

      index
    end

    def self.map_from_ranges(source_start:, destination_start:, length:)
      Ranger.new(
        source_start: source_start,
        source_end: source_start + length - 1,
        destination_start: destination_start,
        length: length,
        offset: destination_start - source_start,
      )
    end
  end

  attr_accessor :seeds, :mappings

  def initialize(file)
    @mappings = {}
    current_mapping = nil
    current_label = nil

    File.readlines(file).each_with_index do |line, index|
      if index.zero?
        @seeds = line.scan(/(\d+)/).map { |match| match[0].to_i }
      else
        next if line == "\n"

        match = line.strip.match(
          /(seed-to-soil|soil-to-fertilizer|fertilizer-to-water|water-to-light|light-to-temperature|temperature-to-humidity|humidity-to-location)/,
        )
        if match
          @mappings[current_label] = current_mapping if current_label
          @mappings[match[1]] = {}
          current_mapping = Mapping.new
          current_label = match[1]
        else
          matches = line.scan(/(\d+)/)
          current_mapping.ranges << Mapping.map_from_ranges(
            source_start: matches[1][0].to_i,
            destination_start: matches[0][0].to_i,
            length: matches[2][0].to_i,
          )
        end
      end
    end
    @mappings[current_label] = current_mapping if current_label
  end

  def solve_part_1
    locations = []

    @seeds.each do |seed|
      locations << get_location(seed)
    end

    locations.min
  end

  def solve_part_2
    locations = []

    @seeds.each_with_index do |seed_start, index|
      next if index.odd?

      puts "Seed starting: #{seed_start}"

      (seed_start..seed_start + @seeds[index + 1]).to_a.each do |actual_seed|
        locations << get_location(actual_seed)
      end
    end

    locations.min
  end

  def get_location(seed)
    source = seed
    7.times do |type|
      source = hop(source, type)
    end

    source
  end

  def hop(source, type)
    @mappings[TYPES[type]][source]
  end

  TYPES = %w[
    seed-to-soil
    soil-to-fertilizer
    fertilizer-to-water
    water-to-light
    light-to-temperature
    temperature-to-humidity
    humidity-to-location
  ].freeze
end
