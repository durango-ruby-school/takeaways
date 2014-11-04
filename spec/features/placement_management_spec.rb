require 'spec_helper'

feature 'Placement Management' do
  background do
    sign_in
  end

  scenario "Assign a takeaway to the rack from the rack screen" do
    rack= create :brochure_rack
    takeaway= create :takeaway

    visit brochure_racks_path
    click_link rack.name
    click_link "Assign Takeaway"

    expect(page).to have_select("Brochure rack", selected: rack.name)

    select takeaway.name, from: 'Takeaway'
    click_button "Assign"
    user_sees_flash_message "Success"

    expect(page).to have_content @takeaway
  end

  scenario "Assign a takeaway to a rack from the takeaway screen" do
    rack= create :brochure_rack
    takeaway= create :takeaway

    visit takeaway_path(takeaway)

    click_link "Assign Takeaway"

    expect(page).to have_select("Takeaway", selected: takeaway.decorate.name)
    select rack.name, from: 'Brochure rack'
    click_button "Assign"
    user_sees_flash_message "Success"

    expect(page).to have_content @takeaway
  end


  scenario "View rack and takeaway on the placement page" do
    placement= create :placement
    visit placement_path(placement)

    expect(page).to have_content placement.brochure_rack.name
    expect(page).to have_content placement.takeaway.name
  end

  scenario "Link to racks on placement page" do
    placement=create :placement
    visit placement_path(placement)

    click_link "Back to Racks"
    expect(page).to have_content "Racks"
  end

  scenario "Mark placement inactve" do
    takeaway = create :takeaway
    rack = create :brochure_rack
    placement = create :placement, takeaway: takeaway, brochure_rack: rack
    stocking = create :stocking, placement: placement

    visit takeaway_path(takeaway)

    user_sees_object placement
    expect do
      click_button "Remove from Rack"
    end.to_not change{Placement.count}
    user_does_not_see_object placement

    #stocking.should exist_in_database
    visit brochure_rack_path(rack)
    user_sees_object stocking

    visit takeaway_path(takeaway)
    click_link "Assign Takeaway"

    select rack.name, from: 'Brochure rack'
    click_button "Assign"

    visit takeaway_path(takeaway)
    user_sees_object placement
  end

  scenario "Delete placement with no stockings" do
    takeaway= create :takeaway
    placement = create :placement, takeaway: takeaway

    visit takeaway_path(takeaway)

    expect do
      click_button "Remove from Rack"
    end.to change{Placement.count}.by 1
    user_does_not_see_object placement
  end
end
