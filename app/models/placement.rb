class Placement < ActiveRecord::Base
  belongs_to :brochure_rack
  belongs_to :takeaway

  has_many :stockings, :dependent => :destroy
  has_one :client, :through => :takeaway

  validates_presence_of(:brochure_rack)
  validates_presence_of(:takeaway)
  validates_uniqueness_of(:takeaway_id, scope: :brochure_rack_id)

  scope :active, -> { where(active: true) }
  scope :active_or_stocked_this_month, -> { joins("LEFT OUTER JOIN stockings ON placements.id = stockings.placement_id").where("placements.active = TRUE OR stockings.stocked_on BETWEEN ? AND ?", Date.today.beginning_of_month, Date.today.end_of_month) }
  scope :stocked_last_month, -> { joins(:stockings).merge(Stocking.last_month) }
  scope :stocked_this_year, -> { joins(:stockings).merge(Stocking.this_year) }
  scope :stocked_last_year, -> { joins(:stockings).merge(Stocking.last_year) }

  delegate :name, to: :takeaway, prefix:true
  delegate :name, to: :client, prefix:true

  def has_been_stocked
    if self.stockings.first
      true
    else
      false
    end
  end

  def has_been_stocked_in_time_frame time_frame
    if self.stockings.in_time_frame(time_frame).first
      true
    else
      false
    end
  end

  def destroy_or_deactivate
    if (self.has_been_stocked)
      self.active = false
      self.save
    else
      self.destroy
    end
  end
end
