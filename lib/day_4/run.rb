#!/usr/bin/env ruby
# frozen_string_literal: true

require "./lib/day_4/solver"
require "pry"

part_1 = Solver.solve_part_1("./lib/day_4/input.txt")
puts "solution part 1: #{part_1}"

part_2 = Solver.solve_part_2("./lib/day_4/input.txt")
puts "solution part 2: #{part_2}"
