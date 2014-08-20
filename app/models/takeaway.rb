class Takeaway < ActiveRecord::Base
  belongs_to :client

  has_many :placements, :dependent => :destroy

  validates_presence_of (:name)
  validates_presence_of(:client)
  validates_uniqueness_of :name, scope: :client_id
end
