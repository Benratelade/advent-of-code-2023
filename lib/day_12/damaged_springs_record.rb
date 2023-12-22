# frozen_string_literal: true

class DamagedSpringsRecord
  attr_reader :quantities

  def initialize(quantities)
    @quantities = quantities
  end

  def regex
    expression = "^\\.*"

    @quantities.each_with_index do |quantity, index|
      expression += "([#]{#{quantity}})"
      expression += (index == @quantities.count - 1) ? "[.]*$" : "[.]+"
    end

    /#{expression}/
  end
end
