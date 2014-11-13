class Api::V1::BrochureRacksController < ApplicationController
  skip_before_filter :authorize
  doorkeeper_for :all, unless: :signed_in?

  def index
    @brochure_racks = BrochureRack.all
  end

  def show
    @brochure_rack = BrochureRack.find params[:id]
  end
end
