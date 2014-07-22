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
      @client = Client.find params[:id]
      @takeaways =@client.takeaways
    end

  private

  def client_params
    params.require(:client).permit(:name)
  end

end
