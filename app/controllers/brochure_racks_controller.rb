class BrochureRacksController < ApplicationController
  def index
    @brochure_racks = BrochureRack.all
  end

  def new
    @brochure_rack= BrochureRack.new
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

  def update
    @brochure_rack = BrochureRack.find params[:id]
    if @brochure_rack.update_attributes brochure_rack_params
      flash[:notice] = "Rack Successfully Updated"
      redirect_to @brochure_rack
    else
      render "edit"
    end
  end

  def destroy
    @brochure_rack = BrochureRack.find params[:id]

    if @brochure_rack.destroy
      flash[:notice] = "Rack Successfully Deleted."
      redirect_to brochure_racks_path
    else
      render @brochure_rack
    end
  end

  def brochure_rack_params
    params.require(:brochure_rack).permit(:name)
  end
end
