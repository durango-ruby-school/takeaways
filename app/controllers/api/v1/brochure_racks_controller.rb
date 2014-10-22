class Api::V1::BrochureRacksController < ApplicationController
  skip_before_filter :authorize
  doorkeeper_for :all

  def index
    @brochure_racks = BrochureRack.all
  end
end
