class Placement < ActiveRecord::Base
  belongs_to :brochure_rack
  belongs_to :takeaway

  validates_presence_of(:brochure_rack)
  validates_presence_of(:takeaway)
end
