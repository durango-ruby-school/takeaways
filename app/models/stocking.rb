class Stocking < ActiveRecord::Base
  belongs_to :placement
  has_one :takeaway, through: :placement

  validates_presence_of(:placement)
  validates_presence_of(:stocked_on)
  validates_presence_of(:quantity)
  validates_numericality_of(:quantity, only_integer: true)
  delegate :name, to: :takeaway, prefix: true

  scope :this_month, -> { where(stocked_on: Date.today.beginning_of_month..Date.today.end_of_month) }
  scope :last_month, -> { where(stocked_on: 1.month.ago.beginning_of_month..1.month.ago.end_of_month) }
  scope :this_year, -> { where(stocked_on: Date.today.beginning_of_year..Date.today.end_of_year) }
  scope :last_year, -> { where(stocked_on: 1.year.ago.beginning_of_year..1.year.ago.end_of_year) }

  class << self
    def in_time_frame(time_frame)
      case time_frame
      when :this_month
        where(stocked_on: Date.today.beginning_of_month..Date.today.end_of_month)
      when :last_month
        where(stocked_on: 1.month.ago.beginning_of_month..1.month.ago.end_of_month)
      when :this_year
        where(stocked_on: Date.today.beginning_of_year..Date.today.end_of_year)
      when :last_year
        where(stocked_on: 1.year.ago.beginning_of_year..1.year.ago.end_of_year)
      end
    end
  end
end
