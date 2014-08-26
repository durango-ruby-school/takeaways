class MassStockingsController < ApplicationController

  def new
    @brochure_rack = BrochureRack.find(params[:brochure_rack_id])
    @mass_stocking = MassStocking.new @brochure_rack
  end

  def create
    @brochure_rack = BrochureRack.find(params[:brochure_rack_id])
    @mass_stocking = MassStocking.new @brochure_rack
    if @mass_stocking.save(params[:mass_stocking])
      flash[:notice]= "Successefully Created"
      redirect_to @brochure_rack
    else
      render "new"
    end
  end
end
