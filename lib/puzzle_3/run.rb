#!/usr/bin/env ruby
# frozen_string_literal: true

require "./lib/puzzle_3/solver"

puts "solution: #{Solver.process_file('./lib/puzzle_3/input.txt')}"
puts "solution to part 2: #{Solver.get_power('./lib/puzzle_3/input.txt')}"
