# frozen_string_literal: true

require_relative "instruction"

class Solver
  attr_accessor :directions, :instructions, :starting_points

  def initialize(file)
    @instructions = {}
    @starting_points = []

    File.readlines(file).each_with_index do |line, index|
      if index.zero?
        @directions = line.strip.chars
      else
        next if line == "\n"

        instruction = line.scan(/([\w]{3})/)
        new_instruction = Instruction.new(source: instruction[0][0], left: instruction[1][0], right: instruction[2][0])
        @instructions[instruction[0][0]] = new_instruction
        @starting_points << new_instruction if new_instruction.source[2] == "A"
      end
    end

    @cache = {}
    @starting_points.each do |starting_point|
      @cache[starting_point] = {}
    end
  end

  def solve_part_1
    destination_reached = false
    count = 0

    starting_point = @instructions["AAA"]

    until destination_reached
      left_or_right = @directions[directions_index(count)]
      count += 1

      starting_point = @instructions[starting_point.next(left_or_right)]

      destination_reached = true if starting_point.source == "ZZZ"
    end

    count
  end

  def solve_part_2
    z_nodes = []
    @starting_points.each_with_index do |starting_point, index|
      z_nodes << get_next_z_node(starting_point, 0)
    end

    z_nodes.map {|node| node[:steps]}.reduce(&:lcm)
  end

  def get_next_z_node(starting_node, steps_count)
    reached_checkpoint = false

    until reached_checkpoint
      starting_node = @instructions[
        starting_node.next(@directions[directions_index(steps_count)]),
      ]
      steps_count += 1

      reached_checkpoint = true if starting_node.source[2] == "Z"
    end

    {
      steps: steps_count,
      checkpoint_node: starting_node,
    }
  end

  def directions_index(count)
    count % @directions.count
  end
end
