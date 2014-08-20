require 'spec_helper'

describe Stocking do
  describe "relationships" do
    it{should belong_to(:placement)}
  end

  describe "validations" do
    it{should validate_presence_of(:placement)}
    it{should validate_presence_of(:stocked_on)}
    it{should validate_presence_of(:quantity)}
  end
end
