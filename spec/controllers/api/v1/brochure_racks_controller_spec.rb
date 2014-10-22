require 'spec_helper'

describe Api::V1::BrochureRacksController do
  render_views

  let(:user){ create :user }
  let(:access_token){ create :access_token, resource_owner_id: user.id }

  describe "GET #index" do
    it "returns all brochure_racks" do
      brochure_rack_1 = create :brochure_rack
      brochure_rack_2 = create :brochure_rack

      get :index, format: :json, access_token: access_token.token

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
      get :index, format: :json

      expect(response.status).to eq(401)
    end
  end
end
