require 'spec_helper'

describe Takeaway do
  it{should validate_presence_of(:name)}
  it{should validate_presence_of(:client)}
  it{should have_many(:placements).dependent(:destroy)}
end
