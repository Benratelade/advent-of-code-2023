# frozen_string_literal: true

require_relative "hasher"
require_relative "operation"
class Solver
  def initialize(file)
    @boxes = {}
    @steps = []
    @operations = []
    File.read(file).strip.split(",").each do |step|
      @steps << step
      @operations << Operation.new(step)
    end

    @hashed_steps = Hasher.hash_all(@steps)
  end

  def solve_part_1
    @hashed_steps.sum
  end

  def solve_part_2
    @operations.each do |operation|
      box = @boxes[operation.hash] || []
      label_index = box.find_index { |lens| lens[:label] == operation.label }

      if operation.operation == "-"
        box.slice!(label_index) if label_index
      elsif label_index
        box[label_index] = { label: operation.label, focal_length: operation.focal_length }
      else
        box << { label: operation.label, focal_length: operation.focal_length }
      end

      @boxes[operation.hash] = box
    end

    focusing_power = 0
    @boxes.each do |box_index, box|
      box.each_with_index do |lens, lens_index|
        focusing_power += (box_index + 1) * (lens_index + 1) * lens[:focal_length]
      end
    end

    focusing_power
  end
end
