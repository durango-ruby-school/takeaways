class PlacementsController < ApplicationController

  def new
    @placement = Placement.new
  end

  def create
    @placement = Placement.new placement_params

    if @placement.save
      redirect_to brochure_rack_path(@placement.brochure_rack), notice: "Success"
    else
      render "new"
    end
  end

  def placement_params
    params.require(:placement).permit(:takeaway_id, :brochure_rack_id)
  end
end
