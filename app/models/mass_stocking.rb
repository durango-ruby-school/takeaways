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
      save_stockings
      true
    else
      false
    end
  end


  def stockings_attributes=(incoming_attrs={})

    attrs_array = incoming_attrs.values

    @stockings = generate_stockings(attrs_array)
  end

  private

  def generate_stockings(attrs_array)
    attrs_array.map { |attrs|
      if attrs[:quantity].present?
        build_stocking(attrs)
      end
    }.compact
  end

  def build_stocking(attrs)
    placement = @rack.placements.find(attrs.fetch(:placement_id))
    placement.stockings.build(quantity: attrs[:quantity],
      stocked_on: stocked_on)
  end

  def save_stockings
    @stockings.each do |stocking|
      stocking.save!
    end
  end
end
