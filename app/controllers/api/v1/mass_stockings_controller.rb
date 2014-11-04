class Api::V1::MassStockingsController < ApplicationController
  skip_before_filter :authorize
  doorkeeper_for :all, unless: :signed_in?

  def create
    render nothing: true
  end
end
