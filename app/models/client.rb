class Client < ActiveRecord::Base
  has_many :takeaways, :dependent => :destroy
  validates_presence_of(:name)
  validates_uniqueness_of(:name)
end
