#!/usr/bin/env ruby
# frozen_string_literal: true

require "./lib/day_4/solver"
require "pry"

solver = Solver.new
puts "solution: #{solver.process_file('./lib/day_4/input.txt')}"
# puts "solution to part 2: #{Solver.get_power('./lib/puzzle_3/input.txt')}"
