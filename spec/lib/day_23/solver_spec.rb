# frozen_string_literal: true
require "day_23/solver"
require "pry"

RSpec.describe Solver do
  before do
    File.create("test-file.txt", "w") do |file|
      file << <<~FILE_CONTENT
      FILE_CONTENT
    end
  end

  after do
    File.delete("test-file.txt")
  end
end
