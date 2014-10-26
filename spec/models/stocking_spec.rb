require 'spec_helper'

describe Stocking do
  describe "relationships" do
    it{should belong_to(:placement)}
    it{should have_one(:takeaway).through(:placement)}
  end

  describe "validations" do
    it{should validate_presence_of(:placement)}
    it{should validate_presence_of(:stocked_on)}
    it{should validate_presence_of(:quantity)}
    it{should validate_numericality_of(:quantity).only_integer}
  end

  describe "delegations" do
    it{should delegate_method(:takeaway_name).to(:takeaway).as(:name)}
  end
end
