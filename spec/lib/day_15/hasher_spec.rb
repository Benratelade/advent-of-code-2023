# frozen_string_literal: true

require "day_15/hasher"
require "pry"

RSpec.describe Hasher do
  describe ".hash_all" do
    it "hashes each item in an array" do
      expect(
        Hasher.hash_all(["rn=1", "cm-", "qp=3", "cm=2", "qp-", "pc=4", "ot=9", "ab=5", "pc-", "pc=6", "ot=7"]),
      ).to eq([30, 253, 97, 47, 14, 180, 9, 197, 48, 214, 231])
    end
  end

  describe ".apply_hash_algorithm" do
    it "returns the hashed value" do
      expect(Hasher.apply_hash_algorithm("HASH")).to eq(52)
      expect(Hasher.apply_hash_algorithm("rn=1")).to eq(30)
    end
  end
end
