require 'spec_helper'

feature 'manage takeaways' do
  background do
    sign_in
  end

  scenario 'CRUD for takeaways' do
    create :client, name: 'DMR'
    create :client, name: 'Railroad'
    create :client, name: 'Animas Code Labs'

    visit takeaways_path

    click_link "New Takeaway"
    fill_in "Name", with: "Stay and Ski"
    select 'Animas Code Labs', from: 'Client'
    click_button "Create Takeaway"

    user_sees_flash_message "Takeaway Successfully Created"
    expect(page).to have_content "Stay and Ski"

    click_link "edit_takeaway"
    fill_in "Name", with: "Kids Ride Free"
    select 'Railroad', from: 'Client'
    click_button "Update Takeaway"
    user_sees_flash_message "Successfully Updated"
    expect(page).to have_content "Kids Ride Free"

    click_link "delete_takeaway"
    expect(page).to have_content "Successfully Deleted"
    expect(page).to have_content "Railroad"
  end

  scenario "View list of all racks for a takeaway" do
    takeaway = create :takeaway
    related_placements = create_list :placement, 2, takeaway: takeaway
    unrelated_placement = create :placement

    visit takeaway_path(takeaway)

    user_sees_objects(related_placements)
    user_does_not_see_object(unrelated_placement)
  end

  scenario "Retire a takeaway", js: true do
    client = create :client
    takeaway = create :takeaway, client: client, name: 'Retiring Takeaway'
    rack = create :brochure_rack

    placement_with_stocking = create :placement, takeaway: takeaway, brochure_rack: rack
    stocking = create :stocking, placement: placement_with_stocking

    empty_rack = create :brochure_rack
    placement_without_stocking = create :placement, takeaway: takeaway, brochure_rack: empty_rack


    visit client_path(client)
    click_link "Retire"
    user_does_not_see_object(takeaway)
    placement_with_stocking.should exist_in_database
    placement_without_stocking.should_not exist_in_database

    check :show_retired_takeaways
    user_sees_object(takeaway)
    expect(page).to have_content "Retired"

    visit takeaway_path(takeaway)
    user_does_not_see_object(placement_with_stocking)

    visit brochure_rack_path(rack)
    user_sees_object(placement_with_stocking)
    expect(page).to have_content "Removed"

    visit client_path(client)
    check :show_retired_takeaways
    click_link "Restore"
    uncheck :show_retired_takeaways
    user_sees_object(takeaway)
  end
end
