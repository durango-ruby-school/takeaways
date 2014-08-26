class MassStocking
  include ActiveModel::Model

  attr_accessor :stocked_on
  attr_reader :stockings

  validates_presence_of :stocked_on

  def initialize rack
    @stockings = []
    @rack = rack
    @rack.placements.each do |placement|
      @stockings << placement.stockings.build
    end
  end

  def stockings_attributes=(value)
  end

  def save(attributes = {})
    self.stocked_on = attributes[:stocked_on]
  end
end
