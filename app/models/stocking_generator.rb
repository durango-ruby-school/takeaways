class StockingGenerator

  def initialize(rack, date)
    @rack = rack
    @stocked_on = date
  end

  def generate_stockings(stocking_attrs_array)
    stocking_attrs_array.map { |attrs|
      if attrs[:quantity].present?
        build_stocking(attrs)
      end
    }.compact
  end

  private

  def build_stocking(attrs)
    placement = @rack.placements.find(attrs.fetch(:placement_id))
    placement.stockings.build(quantity: attrs[:quantity],
      stocked_on: @stocked_on)
  end
end
