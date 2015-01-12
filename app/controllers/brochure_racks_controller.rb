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

    @time_frame_list = { this_month: 'This Month', last_month: "Last Month", this_year: "This Year", last_year: "Last Year" }

    if(params.has_key?(:time_frame))
      @time_frame = params[:time_frame].to_sym
    else
      @time_frame = :this_month
    end

    case @time_frame
    when :this_month
      @placements = @brochure_rack.placements.active_or_stocked_this_month
    when :last_month
      @placements = @brochure_rack.placements.stocked_last_month
    when :this_year
      @placements = @brochure_rack.placements.stocked_this_year
    when :last_year
      @placements = @brochure_rack.placements.stocked_last_year
    end
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
