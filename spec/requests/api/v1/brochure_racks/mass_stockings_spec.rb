require 'spec_helper'
describe 'mass_stocking_api' do
  let(:user){ create :user }
  let(:access_token){ create :access_token, resource_owner_id: user.id }

  describe "POST /api/v1/brochure_racks/:id/mass_stockings" do
    it "creates stockings from the data passed in" do
      brochure_rack_1 = create :brochure_rack
      placement_1 = create :placement, brochure_rack: brochure_rack_1
      placement_2 = create :placement, brochure_rack: brochure_rack_1

      post "api/v1/brochure_racks/#{brochure_rack_1.id}/mass_stockings", access_token: access_token.token,
        stocked_on: "2014-11-02",
        stockings: [
          {
            placement_id: placement_1.id,
            quantity: 7
          },
          {
            placement_id: placement_2.id,
            quantity: 9
          }
        ]
      expect(response.status).to eq (200)
      expect(placement_1.stockings.first.quantity).to eq(7)
      expect(placement_1.stockings.first.stocked_on).to eq(Date.parse "2014-11-02")
      expect(placement_2.stockings.first.quantity).to eq(9)
      expect(placement_2.stockings.first.stocked_on).to eq(Date.parse "2014-11-02")
    end
  end
end
