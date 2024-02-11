# frozen_string_literal: true

require "day_12/damaged_springs_record"

RSpec.describe DamagedSpringsRecord do
  describe ".regex" do
    it "generates a regex based on the provided damaged springs record" do
      damaged_springs_record = DamagedSpringsRecord.new([1, 1, 3])

      expect(damaged_springs_record.regex).to eq(
        /^\.*[#]{1}[.]+[#]{1}[.]+[#]{3}[.]*$/,
      )
    end
  end
end
