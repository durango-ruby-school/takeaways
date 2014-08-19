class BrochureRack < ActiveRecord::Base
  validates_presence_of :name, :number_of_rows, :number_of_columns
  validates_uniqueness_of(:name)
  has_many :placements, :dependent => :destroy
end
