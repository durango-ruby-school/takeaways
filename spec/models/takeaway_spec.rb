require 'spec_helper'

describe Takeaway, "relationships" do
  it{should have_many(:placements).dependent(:destroy)}
end

describe Takeaway, "validations" do
  it{should validate_presence_of(:name)}
  it{should validate_presence_of(:client)}

  describe "uniqueness" do
    it{should validate_uniqueness_of(:name).scoped_to(:client_id)}
  end
end
