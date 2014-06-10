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
      redirect_to @brochure_rack, notice: "Rack Successfully Created."
    else
      render "new"
    end
  end
  
  def show
    @brochure_rack = BrochureRack.find params[:id]
  end
  
  def edit
    @brochure_rack = BrochureRack.find params[:id]
  end
  
  def brochure_rack_params
    params.require(:brochure_rack).permit(:name, :number_of_rows, :number_of_columns)
  end
end