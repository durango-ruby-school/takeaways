class TakeawaysController < ApplicationController
  
  def index
  end
  
  def new
    @takeaway= Takeaway.new
  end
  
end
