#!/usr/bin/env ruby
# frozen_string_literal: true

require "./lib/day_3/solver"
require "pry"

solver = Solver.new
solution = solver.process_file("./lib/day_3/input.txt")
puts "solution: parts: #{solution[0]}, gears: #{solution[1]}"
