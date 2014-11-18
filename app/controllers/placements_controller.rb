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
      redirect_to placement_path(@placement), notice: "Success"
    else
      render "new"
    end
  end

  def show
    @time_frame_list = { this_month: 'This Month', last_month: "Last Month", this_year: "This Year", last_year: "Last Year" }

    @placement = Placement.find params[:id]

    if(params.has_key?(:time_frame))
      @time_frame = params[:time_frame].to_sym
    else
      @time_frame = :this_month
    end

    case @time_frame
    when :this_month
      @stockings = @placement.stockings.this_month
    when :last_month
      @stockings = @placement.stockings.last_month
    when :this_year
      @stockings = @placement.stockings.this_year
    when :last_year
      @stockings = @placement.stockings.last_year
    end
  end

  def destroy
    @placement = Placement.find params[:id]
    if (@placement.stockings.first)
      @placement.active = false
      @placement.save
    else
      @placement.destroy
    end

    redirect_to(:back)
  end

  def placement_params
    params.require(:placement).permit(:takeaway_id, :brochure_rack_id)
  end
end
