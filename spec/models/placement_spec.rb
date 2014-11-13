require 'spec_helper'

describe Placement do
  describe "relationships" do
    it{should belong_to(:brochure_rack)}
    it{should have_one(:client).through(:takeaway)}
    it{should belong_to(:takeaway)}
    it{should have_many(:stockings).dependent(:destroy)}
  end

  describe "validations" do
    it{should validate_presence_of(:brochure_rack)}
    it{should validate_presence_of(:takeaway)}

    describe "uniqueness" do
      before { create :placement }

      it{should validate_uniqueness_of(:takeaway_id).scoped_to(:brochure_rack_id)}
    end
  end

  describe "delagates" do
    it{should delegate_method(:takeaway_name).to(:takeaway).as(:name)}
    it{should delegate_method(:client_name).to(:client).as(:name)}
  end
end
