require 'spec_helper'

feature "Mass Stocking" do
  background do
    sign_in
  end

  scenario "User mass stocks a rack" do
    rack = create :brochure_rack
    placement_1 = create :placement, brochure_rack: rack
    placement_2 = create :placement, brochure_rack: rack

    visit brochure_rack_path(rack)
    click_link "Stock Rack"

    within object_selector(placement_1) do
      find("[data-field=quantity]").set(5)
    end

    within object_selector(placement_2) do
      find("[data-field=quantity]").set(10)
    end

    click_button "Save"
    user_sees_flash_message /success/i

    visit takeaway_path(placement_1.takeaway)
    expect(page).to have_content 5

    visit takeaway_path(placement_2.takeaway)
    expect(page).to have_content 10
  end
end
