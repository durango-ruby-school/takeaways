class Placement < ActiveRecord::Base
  belongs_to :brochure_rack
  belongs_to :takeaway

  has_many :stockings, :dependent => :destroy
  has_one :client, :through => :takeaway


  validates_presence_of(:brochure_rack)
  validates_presence_of(:takeaway)
  validates_uniqueness_of(:takeaway_id, scope: :brochure_rack_id)

  scope :active, -> { where(active: true) }

  delegate :name, to: :takeaway, prefix:true
  delegate :name, to: :client, prefix:true
end
