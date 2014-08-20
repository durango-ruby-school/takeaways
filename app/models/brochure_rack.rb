class BrochureRack < ActiveRecord::Base
  has_many :placements, :dependent => :destroy

  validates_presence_of :name, :number_of_rows, :number_of_columns
  validates_uniqueness_of(:name)
end
