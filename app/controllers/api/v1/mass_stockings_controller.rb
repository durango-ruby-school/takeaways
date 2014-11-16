class Api::V1::MassStockingsController < ApplicationController
  skip_before_filter :authorize
  doorkeeper_for :all, unless: :signed_in?
  protect_from_forgery :except => :create

  def create

    rack = BrochureRack.find(params["brochure_rack_id"])
    date = params["stocked_on"]

    stocking_generator = StockingGenerator.new(rack, date)

    stockings = stocking_generator.generate_stockings(params["stockings"])

    stockings.each do |stocking|
      stocking.save!
    end
    render nothing: true
  end
end
