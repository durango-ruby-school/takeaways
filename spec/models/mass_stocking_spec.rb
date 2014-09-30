require 'spec_helper'

describe MassStocking do
  describe "validations" do
    subject {
      rack = build_stubbed(:brochure_rack)
      described_class.new(rack)
    }

    it{should validate_presence_of(:stocked_on)}
  end

  describe "initialize" do
    it "defaults stocked_on to today's date" do
      brochure_rack = create(:brochure_rack)
      mass_stocking = described_class.new(brochure_rack)

      expect(mass_stocking.stocked_on).to eq Date.today
    end
  end

  describe "#save" do

    it "assigns fields based on the parameters passed in" do
      brochure_rack = create(:brochure_rack)
      placement_1 = create :placement, brochure_rack: brochure_rack

      mass_stocking = described_class.new(brochure_rack)

      mass_stocking.save(
        stocked_on: "2014-08-24",
        stockings_attributes: {
          "0" => {
            quantity: 5,
            placement_id: placement_1.id
          }
        }
      )

      expect(mass_stocking.stocked_on).to eq "2014-08-24"
    end

    context "when valid" do
      it "returns true" do
        brochure_rack = create(:brochure_rack)
        placement_1 = create :placement, brochure_rack: brochure_rack

        mass_stocking = described_class.new(brochure_rack)

        result = mass_stocking.save(
          stocked_on: "2014-08-24",
          stockings_attributes: {
            "0" => {
              quantity: 5,
              placement_id: placement_1.id
            }
          }
        )

        expect(result).to eq(true)
      end

      it "creates new stockings" do
        brochure_rack = create(:brochure_rack)
        placement_1 = create :placement, brochure_rack: brochure_rack

        mass_stocking = described_class.new(brochure_rack)

        mass_stocking.save(
          stocked_on: "2014-08-24",
          stockings_attributes: {
            "0" => {
              quantity: 5,
              placement_id: placement_1.id
            }
          }
        )

        placement_1.reload

        expect(placement_1.stockings.count).to eq(1)

        first_stocking = placement_1.stockings.first
        expect(first_stocking.quantity).to eq(5)
        expect(first_stocking.stocked_on).to eq(Date.parse("2014-08-24"))
      end
    end

    context "when invalid" do
      it "returns false" do
        brochure_rack = create(:brochure_rack)
        mass_stocking = described_class.new(brochure_rack)
        allow(mass_stocking).to receive(:valid?).and_return(false)

        expect(mass_stocking.save).to eq(false)
      end

      it "doesn't create any stockings" do
        brochure_rack = create(:brochure_rack)
        placement_1 = create :placement, brochure_rack: brochure_rack

        mass_stocking = described_class.new(brochure_rack)
        allow(mass_stocking).to receive(:valid?).and_return(false)

        result = mass_stocking.save(
          stocked_on: "2014-08-24",
          stockings_attributes: {
            "0" => {
              quantity: 5,
              placement_id: placement_1.id
            }
          }
        )

        expect(Stocking.count).to eq(0)
      end
    end
  end
end
