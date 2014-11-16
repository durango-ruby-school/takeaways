require 'spec_helper'

describe "Brochure_racks api" do

  let(:user){ create :user }
  let(:access_token){ create :access_token, resource_owner_id: user.id }

  describe "GET /api/v1/brochure_racks" do
    it "returns all brochure_racks with an access token" do
      brochure_rack_1 = create :brochure_rack
      brochure_rack_2 = create :brochure_rack

      get "/api/v1/brochure_racks", access_token: access_token.token

      response_json = JSON.parse response.body,symbolize_names:true

      expect(response.status).to eq(200)
      expect(response_json).to eq({
        brochure_racks: [
          {id: brochure_rack_1.id,name:brochure_rack_1.name},
          {id: brochure_rack_2.id,name:brochure_rack_2.name}
        ]
      })

    end

    it "returns a 401 message without an access token" do
      get "/api/v1/brochure_racks"

      expect(response.status).to eq(401)
    end
  end

  describe "Get /api/v1/brochure_racks/:id" do
    it "Returns the details of a brochure_rack" do
      brochure_rack_1 = create :brochure_rack
      placement_1 = create :placement, brochure_rack: brochure_rack_1
      unrelated_placement = create :placement

      get "api/v1/brochure_racks/#{brochure_rack_1.id}", access_token: access_token.token

      response_json = JSON.parse response.body,symbolize_names:true

      expect(response.status).to eq(200)
      expect(response_json).to eq(
        {
          id: brochure_rack_1.id,
          name:brochure_rack_1.name,
          placements:[
            {
              id: placement_1.id,
              takeaway_name: placement_1.takeaway_name,
              client_name: placement_1.client_name
            }
          ]
        }
      )
    end

    it "returns a 401 message without an access token" do
      brochure_rack_1 = create :brochure_rack

      get "api/v1/brochure_racks/#{brochure_rack_1.id}"

      expect(response.status).to eq(401)
    end
  end
end
