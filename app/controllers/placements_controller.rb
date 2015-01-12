class PlacementsController < ApplicationController

  def new
    @placement= Placement.new takeaway_id: params[:takeaway_id], brochure_rack_id: params[:brochure_rack_id]
  end

  def create
    @placement = Placement.find_by_brochure_rack_id_and_takeaway_id(
      placement_params[:brochure_rack_id],
      placement_params[:takeaway_id])

    if (@placement)
      @placement.active = true
    else
      @placement = Placement.new placement_params
    end

    if @placement.save
      redirect_to @placement.takeaway, notice: "Success"
    else
      render "new"
    end
  end

  def destroy
    @placement = Placement.find params[:id]
    @placement.destroy_or_deactivate

    redirect_to(:back)
  end

  def placement_params
    params.require(:placement).permit(:takeaway_id, :brochure_rack_id)
  end
end
