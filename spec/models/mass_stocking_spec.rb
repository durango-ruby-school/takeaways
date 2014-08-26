require 'spec_helper'

describe MassStocking do
  describe "validations" do
    subject {
      rack = build_stubbed(:brochure_rack)
      described_class.new(rack)
    }

    it{should validate_presence_of(:stocked_on)}
  end

  describe "#save" do

    it "assigns fields based on the parameters passed in" do
      brochure_rack = build_stubbed(:brochure_rack)
      mass_stocking = described_class.new(brochure_rack)

      mass_stocking.save stocked_on: "2014-08-24"

      expect(mass_stocking.stocked_on).to eq "2014-08-24"
    end

    context "when valid" do
      it "returns true"
    end

    context "when invalid" do
      it "returns false"
    end
  end
end
