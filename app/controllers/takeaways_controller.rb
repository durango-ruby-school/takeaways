class TakeawaysController < ApplicationController

  def index
  end

  def new
    @takeaway= Takeaway.new client_id: params[:client_id]
  end

  def create
    @takeaway = Takeaway.new takeaway_params
    if @takeaway.save
      flash[:notice]= "Takeaway Successfully Created"
      redirect_to takeaway_path(@takeaway)
      else
        render 'new'
    end
  end

  def show
    @takeaway= Takeaway.find(params[:id]).decorate
  end

  def edit
    @takeaway= Takeaway.find params[:id]
  end

  def update
    @takeaway = Takeaway.find params[:id]
    if @takeaway.update_attributes takeaway_params
      flash[:notice]= "Takeaway Successfully Updated"
      redirect_to takeaway_path(@takeaway)
      else
      render 'edit'
    end
  end

  def destroy
    @takeaway = Takeaway.find params[:id]
binding.pry
    if @takeaway.placements.first
      retire_takeaway @takeaway
      flash[:notice] = "Takeaway Successfully Retired"
      redirect_to client_path(@takeaway.client)
    else
      if @takeaway.destroy
        flash[:notice] = "Takeaway Successfully Deleted"
        redirect_to takeaways_path
      else
        render @takeaway
      end
    end
  end

  private

  def takeaway_params
    params.require(:takeaway).permit(:name, :client_id)
  end

  def retire_takeaway takeaway
    takeaway.transaction do
      at_least_one_stocking_found = false

      takeaway.placements.each do |placement|
        if placement.stockings.first
          placement.active = false
          placement.save

          at_least_one_stocking_found = true
        else
          placement.destroy
        end
      end

      if at_least_one_stocking_found
        takeaway.active = false
        takeaway.save
      else
        takeaway.destroy
      end
    end
  end
end
