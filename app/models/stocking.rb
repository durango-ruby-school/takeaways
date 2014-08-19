class Stocking < ActiveRecord::Base
  belongs_to :placement

  validates_presence_of(:placement)
  validates_presence_of(:stocked_on)
  validates_presence_of(:quantity)
end
