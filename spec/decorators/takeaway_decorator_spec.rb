require 'spec_helper'

describe TakeawayDecorator do

  describe "#takeaway name decorator" do
    it "returns the client name and takeaway name" do
      takeaway = build_stubbed(:takeaway)
      takeaway_decorator = TakeawayDecorator.new takeaway

      expect(takeaway_decorator.name).to eq("#{takeaway.client.name} - #{takeaway.name}")
    end
  end
end
