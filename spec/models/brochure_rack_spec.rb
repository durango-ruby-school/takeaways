require 'spec_helper'

describe BrochureRack do
  it{should have_many(:placements).dependent(:destroy)}

  describe "validations" do
    it{should validate_presence_of(:name)}

    describe "uniqueness" do
      before { create :brochure_rack}
      it {should validate_uniqueness_of(:name)}
    end
  end
end
