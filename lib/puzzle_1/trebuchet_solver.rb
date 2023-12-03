# frozen_string_literal: true

module TrebuchetSolver
  def self.process_file(file)
    total = 0

    File.readlines(file).each do |line|
      total += get_line_calibration_value(line.strip)
    end

    total
  end

  def self.get_line_calibration_value(line)
    first_match = line.match(/^.*?(\d)/)

    return 0 unless first_match

    first_digit = line.match(/^.*?(\d)/)[1]
    second_digit = line.reverse.match(/^.*?(\d)/)[1]

    "#{first_digit}#{second_digit}".to_i
  end
end
