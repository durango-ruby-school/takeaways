class StockingsController < ApplicationController

  def new
    @placement= Placement.find params[:placement_id]
    @stocking= @placement.stockings.build
  end

  def create
    @placement= Placement.find params[:placement_id]
    @stocking= @placement.stockings.build stocking_params
    if @stocking.save
      flash[:notice]= "Successfully Created"
      redirect_to @placement.takeaway
    else
      render "new"
    end
  end

  def show
    @stocking = Stocking.find params[:id]
  end

  def edit
    @stocking = Stocking.find params[:id]
  end

  def update
    @stocking = Stocking.find params[:id]

    if @stocking.update_attributes stocking_params
      flash[:notice]= "Successfully Updated"
      redirect_to @stocking.takeaway
    else
      render "edit"
    end
  end

  def destroy
    @stocking = Stocking.find params[:id]
    @stocking.destroy
    flash[:notice] = "Successfully Deleted"
    redirect_to @stocking.takeaway
  end

  private

  def stocking_params
    params.require(:stocking).permit(:stocked_on, :quantity, :edit)
  end
end
