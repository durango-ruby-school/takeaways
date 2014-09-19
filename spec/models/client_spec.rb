require 'spec_helper'

describe Client, "relationships" do
  it {should have_many(:takeaways).dependent(:destroy)}

  describe "validations" do
    it{should validate_presence_of(:name)}

    describe "uniqueness" do
      before { create :client}
      it {should validate_uniqueness_of(:name)}
    end
  end
end
