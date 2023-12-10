# frozen_string_literal: true

class Instruction
  attr_accessor :source, :left, :right

  def initialize(source:, left:, right:)
    @source = source
    @left = left
    @right = right
  end

  def next(left_or_right)
    return left if left_or_right == "L"

    right if left_or_right == "R"
  end
end
