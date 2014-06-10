class BrochureRack < ActiveRecord::Base
  validates_presence_of :name, :number_of_rows, :number_of_columns
  
end
