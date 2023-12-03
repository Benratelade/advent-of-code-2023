# frozen_string_literal: true

module TrebuchetSolverRedo
  def self.process_file(file)
    total = 0

    File.readlines(file).each do |line|
      total += get_line_calibration_value(line.strip)
    end

    total
  end

  def self.get_line_calibration_value(line)
    matches = line.scan(regex)

    return 0 if matches.empty?

    first_digit = convert_to_digit(matches[0][0])

    second_digit_candidate = matches.last[0]

    end_of_string = line[line.index(second_digit_candidate, 0) + 1, line.length]
    final_matches = end_of_string.scan(regex)

    until final_matches.empty?
      second_digit_candidate = final_matches.last[0] unless final_matches.empty?

      break unless end_of_string.index(second_digit_candidate, 0)

      end_of_string = end_of_string[end_of_string.index(second_digit_candidate, 0) + 1, end_of_string.length]
      final_matches = end_of_string.scan(regex)
    end
    second_digit = convert_to_digit(second_digit_candidate)

    "#{first_digit}#{second_digit}".to_i
  end

  def self.convert_to_digit(number)
    return number if number.match(/\d/)

    mappings[number]
  end

  def self.mappings
    {
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9",
    }
  end

  def self.regex
    /(\d|one|two|three|four|five|six|seven|eight|nine)/
  end
end
