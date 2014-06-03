class BrochureRacksController < ApplicationController
  def index
    @brochure_racks = BrochureRack.all
  end
  
  def new
    @brochure_rack = BrochureRack.new
  end
  
  def create
    @brochure_rack = BrochureRack.new brochure_rack_params
    if @brochure_rack.save
      flash[:notice] = "Rack Successfully Created."
      
      redirect_to @brochure_rack
    else
      render "new"
    end
  end
end