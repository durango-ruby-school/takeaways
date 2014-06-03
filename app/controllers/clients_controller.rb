class ClientsController < ApplicationController

  def index
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

    def show
    end

  private

  def client_params
    params.require(:client).permit(:name)
  end

end