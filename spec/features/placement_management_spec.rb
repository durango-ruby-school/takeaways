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

  scenario "Mark placement inactve" do
    takeaway = create :takeaway
    rack = create :brochure_rack
    placement = create :placement, takeaway: takeaway, brochure_rack: rack
    stocking = create :stocking, placement: placement

    visit takeaway_path(takeaway)

    user_sees_object placement
    user_sees_object stocking
    expect do
      click_link "Remove from Rack"
    end.to_not change{Placement.count}
    user_sees_object placement
    user_sees_object stocking

    visit brochure_rack_path(rack)
    user_sees_object placement
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
      click_link "Remove from Rack"
    end.to change{Placement.count}.by -1
    user_does_not_see_object placement
  end

  scenario "Show placements in time frame for given takeaway", js: true do
    takeaway = create :takeaway
    active_placement = create :placement, takeaway: takeaway
    inactive_placement_stocked_this_month = create :placement, takeaway: takeaway
    inactive_placement_stocked_last_month = create :placement, takeaway: takeaway
    inactive_placement_stocked_last_year = create :placement, takeaway: takeaway
    stocking_this_month = create :stocking, placement: inactive_placement_stocked_this_month, stocked_on: Date.today
    stocking_last_month = create :stocking, placement: inactive_placement_stocked_last_month, stocked_on: 1.month.ago
    stocking_last_year = create :stocking, placement: inactive_placement_stocked_last_year, stocked_on: 1.year.ago

    inactive_placement_stocked_this_month.destroy_or_deactivate
    inactive_placement_stocked_last_month.destroy_or_deactivate
    inactive_placement_stocked_last_year.destroy_or_deactivate

    visit takeaway_path(takeaway)
    user_sees_object active_placement
    user_sees_object inactive_placement_stocked_this_month
    user_does_not_see_object inactive_placement_stocked_last_month
    select 'Last Month', from: :time_frame
    user_does_not_see_object active_placement
    user_does_not_see_object inactive_placement_stocked_this_month
    user_sees_object inactive_placement_stocked_last_month
    select 'This Year', from: :time_frame
    user_does_not_see_object active_placement
    user_sees_object inactive_placement_stocked_this_month
    user_does_not_see_object inactive_placement_stocked_last_year
    select 'Last Year', from: :time_frame
    user_does_not_see_object active_placement
    user_does_not_see_object inactive_placement_stocked_this_month
    user_sees_object inactive_placement_stocked_last_year
  end

  scenario "Show placements in time frame for given rack", js: true do
    rack = create :brochure_rack
    active_placement = create :placement, brochure_rack: rack
    inactive_placement_stocked_this_month = create :placement, brochure_rack: rack
    inactive_placement_stocked_last_month = create :placement, brochure_rack: rack
    inactive_placement_stocked_last_year = create :placement, brochure_rack: rack
    stocking_this_month = create :stocking, placement: inactive_placement_stocked_this_month, stocked_on: Date.today
    stocking_last_month = create :stocking, placement: inactive_placement_stocked_last_month, stocked_on: 1.month.ago
    stocking_last_year = create :stocking, placement: inactive_placement_stocked_last_year, stocked_on: 1.year.ago

    inactive_placement_stocked_this_month.destroy_or_deactivate
    inactive_placement_stocked_last_month.destroy_or_deactivate
    inactive_placement_stocked_last_year.destroy_or_deactivate

    visit brochure_rack_path(rack)
    user_sees_object active_placement
    user_sees_object inactive_placement_stocked_this_month
    user_does_not_see_object inactive_placement_stocked_last_month
    select 'Last Month', from: :time_frame
    user_does_not_see_object active_placement
    user_does_not_see_object inactive_placement_stocked_this_month
    user_sees_object inactive_placement_stocked_last_month
    select 'This Year', from: :time_frame
    user_does_not_see_object active_placement
    user_sees_object inactive_placement_stocked_this_month
    user_does_not_see_object inactive_placement_stocked_last_year
    select 'Last Year', from: :time_frame
    user_does_not_see_object active_placement
    user_does_not_see_object inactive_placement_stocked_this_month
    user_sees_object inactive_placement_stocked_last_year
  end
end
