# frozen_string_literal: true

require "day_15/operation"
require "pry"

RSpec.describe Operation do
  describe ".initialize" do
    it "sets a label" do
      expect(Operation.new("rn=1").label).to eq("rn")
    end

    it "sets an operation" do
      expect(Operation.new("rn=1").operation).to eq("=")
    end

    it "sets a hash" do
      expect(Operation.new("rn=1").hash).to eq(0)
    end

    it "sets a focal length if the operation is equal ('=')" do
      expect(Operation.new("rn=1").focal_length).to eq(1)
    end

    it "does NOT set a focal length for minus operations" do
      expect(Operation.new("cm-").focal_length).to eq(nil)
    end
  end
end
