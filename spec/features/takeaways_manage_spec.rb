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

  scenario 'View assigned racks on takeaway page' do
    client = create :client
    takeaway = create :takeaway, client: client
    rack = create :brochure_rack, name: 'Rack123'
    placement = create :placement, brochure_rack: rack, takeaway: takeaway
    
    visit takeaway_path(takeaway)
    expect(page).to have_content 'Rack123'
  end

  def update_a_takeaway takeaway_name
    click_link "edit_takeaway"
    fill_in "Name", with: takeaway_name
    select 'Railroad', from: 'Client'
    click_button "Update Takeaway"
  end
end
