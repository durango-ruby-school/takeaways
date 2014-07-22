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
    @takeaway= Takeaway.find params[:id]
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
      if @takeaway.destroy
        flash[:notice] = "Brochure Successfully Deleted"
        redirect_to takeaways_path
    else
        render @takeaway
    end
  end

  private

  def takeaway_params
    params.require(:takeaway).permit(:name, :client_id)
  end

end
