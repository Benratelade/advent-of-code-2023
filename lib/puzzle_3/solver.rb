# frozen_string_literal: true

module Solver
  def self.cubes
    {
      "red" => 12,
      "green" => 13,
      "blue" => 14,
    }
  end

  def self.process_file(file)
    total = 0

    File.readlines(file).each do |line|
      data = get_line_data(line.strip)

      total += data["id"] if line_is_possible?(data)
    end

    total
  end

  def self.get_power(file)
    total = 0

    File.readlines(file).each do |line|
      total += cubeset_power(line.strip)
    end

    total
  end

  def self.get_line_data(line)
    data = { "draws" => [] }
    data["id"] = line.match(/Game (\d+)/)[1].to_i

    line = line[line.index(":") + 1, line.length + 1]
    draws_report = line.split("; ")
    draws_report.each do |draw_report|
      draw_data = {}

      draw_report.scan(/(\d+)\s(red|blue|green)/).each do |match|
        draw_data[match[1]] = match[0].to_i
      end

      data["draws"] << draw_data
    end

    data
  end

  def self.line_is_possible?(line_data)
    return false if line_data.empty?

    line_data["draws"].all? do |draw|
      draw.all? do |color, quantity|
        quantity <= Solver.cubes[color]
      end
    end
  end

  def self.minimum_cubeset(line)
    cubeset = { "red" => 0, "green" => 0, "blue" => 0 }
    data = get_line_data(line)
    data["draws"].each do |draw|
      draw.each do |color, count|
        cubeset[color] = count unless cubeset[color] > count
      end
    end

    cubeset
  end

  def self.cubeset_power(line)
    cubeset = minimum_cubeset(line)

    power = 0
    cubeset.each_value do |value|
      if power.zero?
        power += value
      else
        power *= value
      end
    end

    power
  end
end
