class Api::V1::BrochureRacksController < ApplicationController
  skip_before_filter :authorize

  def index
    @brochure_racks = BrochureRack.all
  end
end
