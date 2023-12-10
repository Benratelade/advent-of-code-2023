# frozen_string_literal: true

require "day_8/instruction"
require "pry"

RSpec.describe Instruction do
  describe "#next" do
    it "tells you where to go next depending on Left of Right instruction" do
      instruction = Instruction.new(source: "BBB", left: "DDD", right: "EEE")

      expect(instruction.next("L")).to eq("DDD")
      expect(instruction.next("R")).to eq("EEE")
    end
  end
end
