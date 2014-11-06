require 'spec_helper'

describe StockingGenerator do
  describe "#generate_stockings" do
    it "returns a new stocking for each item in the stocking_attrs_array" do
      brochure_rack = create(:brochure_rack)
      placement_1 = create :placement, brochure_rack: brochure_rack
      date = Date.yesterday
      stocking_generator = StockingGenerator.new(brochure_rack, date)

      results = stocking_generator.generate_stockings([{ quantity: 5, placement_id: placement_1.id }])

      expect(results.length).to eq(1)

      generated_stocking = results.first
      expect(generated_stocking.quantity).to eq(5)
      expect(generated_stocking.placement_id).to eq(placement_1.id)
      expect(generated_stocking.stocked_on).to eq(date)
    end

    it "does not build a stocking if the quantity is nil" do
      brochure_rack = create(:brochure_rack)
      placement_1 = create :placement, brochure_rack: brochure_rack
      date = Date.yesterday
      stocking_generator = StockingGenerator.new(brochure_rack, date)

      results = stocking_generator.generate_stockings([{ quantity: nil, placement_id: placement_1.id }])

      expect(results.length).to eq(0)
    end

    it "does not save the stockings that it generates" do
      brochure_rack = create(:brochure_rack)
      placement_1 = create :placement, brochure_rack: brochure_rack
      date = Date.yesterday
      stocking_generator = StockingGenerator.new(brochure_rack, date)

      results = stocking_generator.generate_stockings([{ quantity: 5, placement_id: placement_1.id }])

      expect(results.first).not_to be_persisted
    end
  end
end
