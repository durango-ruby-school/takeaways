class PlacementsController < ApplicationController

  def new
    @placement= Placement.new takeaway_id: params[:takeaway_id], brochure_rack_id: params[:brochure_rack_id]
  end

  def create
    @placement = Placement.new placement_params
    if @placement.save
      redirect_to placement_path(@placement), notice: "Success"
    else
      render "new"
    end
  end

  def show
    @start_date = 1.week.ago
    @end_date = Date.today

    @placement = Placement.find params[:id]
    @stockings = @placement.stockings.where(stocked_on: @start_date..@end_date)
  end

  def filter
    @start_date = 2.weeks.ago
    @end_date = Date.today
    @placement = Placement.find params[:id]
    @stockings = @placement.stockings.where(stocked_on: @start_date..@end_date)
  end

  def placement_params
    params.require(:placement).permit(:takeaway_id, :brochure_rack_id)
  end
end
