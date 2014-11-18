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

    update_a_takeaway "Kids Ride Free"
    user_sees_flash_message "Successfully Updated"
    expect(page).to have_content "Kids Ride Free"

    click_link "delete_takeaway"
    expect(page).to have_content "Successfully Deleted"
    expect(page).to_not have_content "Railroad"
  end

  scenario "View list of all racks for a takeaway" do
    takeaway = create :takeaway
    related_placements = create_list :placement, 2, takeaway: takeaway
    unrelated_placement = create :placement

    visit takeaway_path(takeaway)

    user_sees_objects(related_placements)
    user_does_not_see_object(unrelated_placement)
  end

  scenario "Retire a takeaway" do
    client = create :client
    takeaway = create :takeaway, client: client
    rack = create :rack
    placement = create :placement, takeaway: takeaway, rack: rack

    visit client_path(client)
    click_link "Retire"
    user_does_not_see_object(takeaway)

    check "Show Retired Takeaways"
    user_sees_object(takeaway)
    expect(page).to have_content "Retired"

    visit takeaway_path(takeaway)
    user_does_not_see_object(placement)

    visit rack_path(rack)
    user_sees_object(placement)
    expect(page).to have_content "Removed"

    visit client_path(client)
    check "Show Retired Takeaways"
    click_link "Restore"
    uncheck "Show Retired Takeaways"
    user_sees_object(takeaway)
  end

  def update_a_takeaway takeaway_name
    click_link "edit_takeaway"
    fill_in "Name", with: takeaway_name
    select 'Railroad', from: 'Client'
    click_button "Update Takeaway"
  end
end
