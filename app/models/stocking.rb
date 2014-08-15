class Stocking < ActiveRecord::Base
  #model_name.instance_variable_set :@route_key, 'stocking'
  belongs_to :placement

  validates_presence_of(:placement)
  validates_presence_of(:stocked_on)
  validates_presence_of(:quantity)
end
