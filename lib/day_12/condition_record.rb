# frozen_string_literal: true

require_relative "springs_list"
require_relative "damaged_springs_record"

class ConditionRecord
  attr_accessor :springs_list, :damaged_spring_record

  def initialize(line)
    springs_list_data, damaged_spring_record_data = line.strip.split

    @springs_list = SpringsList.new(springs_list_data.chars)
    @damaged_spring_record = DamagedSpringsRecord.new(damaged_spring_record_data.split(",").map(&:to_i))
  end

  def possible_solutions
    @springs_list.all_possible_solutions.select do |solution|
      solution.join.match(@damaged_spring_record.regex)
    end
  end

  def possible_solutions_part_2
    springs_list = @springs_list.springs.join
    damaged_springs_record = @damaged_spring_record.quantities.join(",")
    double_length_solutions = ConditionRecord.new("?#{springs_list} #{damaged_springs_record}")

    possible_solutions_count = possible_solutions.count
    factor = double_length_solutions.possible_solutions.count

    possible_solutions_count * factor * factor * factor * factor
  end
end
