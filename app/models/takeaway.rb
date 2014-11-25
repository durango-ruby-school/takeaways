class Takeaway < ActiveRecord::Base
  belongs_to :client

  has_many :placements, :dependent => :destroy

  validates_presence_of (:name)
  validates_presence_of(:client)
  validates_uniqueness_of :name, scope: :client_id

  scope :active, -> { where(active: true) }

  #inner join eliminates takeaways with no stockings
  scope :have_been_stocked, -> { joins(placements: :stockings) }

  def has_been_stocked
    first_placement = self.placements.first

    if first_placement
      if first_placement.stockings.first
        true
      else
        false
      end
    else
      false
    end
  end
end
