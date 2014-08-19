class Client < ActiveRecord::Base
  has_many :takeaways, :dependent => :destroy
end
