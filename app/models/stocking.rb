class Stocking < ActiveRecord::Base
  belongs_to :placement
  has_one :takeaway, through: :placement

  validates_presence_of(:placement)
  validates_presence_of(:stocked_on)
  validates_presence_of(:quantity)
  validates_numericality_of(:quantity, only_integer: true)
  delegate :name, to: :takeaway, prefix: true
end
