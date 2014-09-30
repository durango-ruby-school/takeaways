class Stocking < ActiveRecord::Base
  belongs_to :placement
  has_one :takeaway, through: :placement

  validates_presence_of(:placement)
  validates_presence_of(:stocked_on)
  validates_presence_of(:quantity)
  delegate :name, to: :takeaway, prefix: true
end
