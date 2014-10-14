class BrochureRack < ActiveRecord::Base
  has_many :placements, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of(:name)
end
