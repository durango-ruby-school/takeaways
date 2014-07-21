class Takeaway < ActiveRecord::Base
  belongs_to :client
  validates_presence_of(:name)
  validates_presence_of(:client)
 
  
end
