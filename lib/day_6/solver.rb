# frozen_string_literal: true

class Solver
  attr_accessor :races, :race

  def initialize(file)
    @races = []
    @race = nil
    durations, records = nil
    one_duration, record = nil

    File.readlines(file).each_with_index do |line, index|
      if index.zero?
        durations = line.scan(/(\d+)/).flatten
        one_duration = durations.join.to_i
      else
        records = line.scan(/(\d+)/).flatten
        record = records.join.to_i
      end
    end
    @race = Race.new(duration: one_duration, record: record)

    durations.each_with_index do |duration, index|
      @races << Race.new(duration: duration.to_i, record: records[index].to_i)
    end
  end

  def solve_part_1
    winning_strategies_counts = @races.map do |race|
      race.winning_strategies.count
    end

    product_of_values = 1
    winning_strategies_counts.each do |count|
      product_of_values = count * product_of_values
    end

    product_of_values
  end

  def solve_part_2
    @race.winning_strategies.count
  end
end

class Race
  attr_accessor :duration, :record

  def initialize(duration:, record:)
    @duration = duration
    @record = record
  end

  def winning_strategies
    strategies = []
    (1..duration - 1).each do |press_duration|
      distance = press_duration * (@duration - press_duration)

      break if distance <= record && strategies.any?
      next if distance <= @record

      strategies << {
        press_duration: press_duration,
        distance: distance,
      }
    end

    strategies
  end
end
