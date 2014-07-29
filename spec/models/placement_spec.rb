require 'spec_helper'

describe Placement do
  describe "relationships" do
      it{should belong_to(:brochure_rack)}
      it{should belong_to(:takeaway)}
  end

  describe "validations" do
    it{should validate_presence_of(:brochure_rack)}
    it{should validate_presence_of(:takeaway)}
  end
end
