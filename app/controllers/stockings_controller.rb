class StockingsController < ApplicationController

  def new
    @placement= Placement.find params[:placement_id]
    @stocking= @placement.stockings.build
  end

  def create
    @placement= Placement.find params[:placement_id]
    @stocking= @placement.stockings.build stocking_params
    if @stocking.save
      flash[:notice]= "Successfully Updated"
      redirect_to [@placement]
    else
      render "new"
    end
  end

private

  def stocking_params
    params.require(:stocking).permit(:stocked_on, :quantity)
  end

end
