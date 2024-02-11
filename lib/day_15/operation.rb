# frozen_string_literal: true

require_relative "hasher"

class Operation
  attr_reader :label, :operation, :hash, :focal_length

  def initialize(string)
    @operation = string.match(/=|-/)[0]
    @label = string.split(/=|-/)[0]
    @hash = Hasher.apply_hash_algorithm(@label)

    @focal_length = string.split("=").last.to_i if @operation == "="
  end
end
