class ClientsController < ApplicationController

  def index
    @clients = Client.all
  end

  def new
    @client= Client.new
  end

  def create
    @client = Client.new client_params
    if @client.save
      flash[:notice]= "Successfully Created Client"
      redirect_to client_path(@client)
    else
      render 'new'
    end
  end

  def edit
    @client = Client.find params[:id]
  end

  def destroy
    @client = Client.find params[:id]
    if @client.destroy
      flash[:notice] = "Client Successfully Deleted"
      redirect_to clients_path
    else
      render @client
    end
  end

  def update
    @client = Client.find params[:id]
    if @client.update_attributes client_params
      flash[:notice]= "Successfully Updated Client"
      redirect_to client_path(@client)

    else
      render "edit"
    end
  end

    def show
      if(params.has_key?(:show_retired_takeaways))
        @show_retired_takeaways = params[:show_retired_takeaways]
      else
        @show_retired_takeaways = false
      end

      @client = Client.find params[:id]

      if @show_retired_takeaways
        @takeaways = @client.takeaways
      else
        @takeaways = @client.takeaways.active
      end
    end

  private

  def client_params
    params.require(:client).permit(:name, :contact, :street, :city, :state, :zip, :phone, :email)
  end

end
