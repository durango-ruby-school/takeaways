class MassStocking
  include ActiveModel::Model

  attr_accessor :stocked_on
  attr_reader :stockings

  validates_presence_of :stocked_on

  def initialize rack
    @stockings = []
    @stocked_on = Date.today
    @rack = rack
    @rack.placements.each do |placement|
      @stockings << placement.stockings.build
    end
  end


  def save(attributes = {})
    self.stocked_on = attributes[:stocked_on]
    self.stockings_attributes = attributes.fetch(:stockings_attributes, {})

    if valid?
      @stockings.each do |stocking|
        stocking.save!
      end
      true
    else
      false
    end
  end


  def stockings_attributes=(incoming_attrs={})

    attrs_array = incoming_attrs.values

    @stockings = []

    attrs_array.each do |attrs|
      placement = @rack.placements.find(attrs.fetch(:placement_id))
      @stockings << placement.stockings.build(quantity: attrs[:quantity],
        stocked_on: stocked_on)
    end

  end
end
