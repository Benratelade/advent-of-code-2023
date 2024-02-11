# frozen_string_literal: true

require_relative "springs_list"
require_relative "damaged_springs_record"

class ConditionRecord
  attr_accessor :springs_list, :damaged_spring_record

  def initialize(line)
    springs_list_data, damaged_spring_record_data = line.strip.split

    @damaged_spring_record = DamagedSpringsRecord.new(damaged_spring_record_data.split(",").map(&:to_i))
    @springs_list = SpringsList.new(springs_list_data.chars, @damaged_spring_record)
  end

  def possible_solutions
    @possible_solutions ||= @springs_list.all_possible_solutions
  end

  def last_group_never_changes
    last_match_data_first_solution =
      possible_solutions[0].join.to_enum(
        :scan,
        @damaged_spring_record.regex,
      ).map { Regexp.last_match }[0]

    possible_solutions.all? do |solution|
      last_match_data = solution.join.to_enum(:scan, @damaged_spring_record.regex).map { Regexp.last_match }[0]
      last_match_data.begin(
        last_match_data.to_a.length - 1,
      ) == last_match_data_first_solution.begin(
        last_match_data_first_solution.to_a.length - 1,
      )
    end
  end

  def possible_solutions_part_2
    springs_list = @springs_list.springs.join
    damaged_springs_record = @damaged_spring_record.quantities.join(",")

    possible_solutions_count = possible_solutions.count
    double_solution = ConditionRecord.new(
      "#{springs_list}?#{springs_list} #{damaged_springs_record},#{damaged_springs_record}",
    )
    factor = double_solution.possible_solutions.count / possible_solutions_count
    # first_half_solutions = ConditionRecord.new("#{springs_list}? #{damaged_springs_record}")
    # second_half_solutions = ConditionRecord.new("?#{springs_list} #{damaged_springs_record}")

    # highest_count = if last_group_never_changes
    #                   second_half_solutions.possible_solutions.count
    #                 else
    #                   first_half_solutions.possible_solutions.count
    #                 end
    # factor = highest_count

    possible_solutions_count * factor * factor * factor * factor
  end
end
