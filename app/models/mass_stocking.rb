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
      generate_stockings
      true
    else
      false
    end
  end


  def stockings_attributes=(incoming_attrs={})

    attrs_array = incoming_attrs.values

    @stockings = []

    attrs_array.each do |attrs|
      if attrs[:quantity].present?
        add_to_stockings(attrs)
      end
    end
  end

  private

  def add_to_stockings(attrs)
    placement = @rack.placements.find(attrs.fetch(:placement_id))
    @stockings << placement.stockings.build(quantity: attrs[:quantity],
      stocked_on: stocked_on)
  end

  def generate_stockings
    @stockings.each do |stocking|
      stocking.save!
    end
  end
end
