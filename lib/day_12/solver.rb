# frozen_string_literal: true

require_relative "condition_record"

class Solver
  attr_accessor :condition_records

  def initialize(file)
    @condition_records = []

    File.readlines(file).each do |line|
      @condition_records << ConditionRecord.new(line.strip)
    end
  end

  def solve_part_1
    @condition_records.sum do |condition_record|
      condition_record.possible_solutions.count
    end
  end

  def solve_part_2
    @condition_records.sum(&:possible_solutions_part_2)
  end
end
