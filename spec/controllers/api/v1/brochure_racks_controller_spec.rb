require 'spec_helper'

describe Api::V1::BrochureRacksController do
  render_views
  describe "GET #index" do
    it "returns all brochure_racks" do
      brochure_rack_1 = create :brochure_rack
      brochure_rack_2 = create :brochure_rack

      get :index, format: :json

      response_json = JSON.parse response.body,symbolize_names:true

      expect(response_json).to eq({
        brochure_racks: [
          {id: brochure_rack_1.id,name:brochure_rack_1.name},
          {id: brochure_rack_2.id,name:brochure_rack_2.name}
        ]
      })

    end
  end
end
