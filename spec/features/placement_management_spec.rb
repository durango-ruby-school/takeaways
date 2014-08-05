require 'spec_helper'

feature 'Placement Management' do

  scenario "Assign a takeaway to the rack from the rack screen" do
    rack= create :brochure_rack
    client= create :client, name: 'Animas Code Labs'
    takeaway= create :takeaway, name: "Summer", client: client

    visit brochure_racks_path
    click_link rack.name
    click_link "Assign Takeaway"

    select takeaway.name, from: 'Takeaway'
    select rack.name, from: 'Brochure rack'
    click_button "Assign"
    user_sees_flash_message "Success"

    expect(page).to have_content @takeaway
  end

  scenario "Assign a takeaway to a rack from the takeaway screen" do
    rack= create :brochure_rack
    client= create :client, name: 'Animas Code Labs'
    takeaway= create :takeaway, name: "Summer", client: client

    visit takeaway_path(takeaway)

    click_link "Assign Takeaway"

    select takeaway.name, from: 'Takeaway'
    select rack.name, from: 'Brochure rack'
    click_button "Assign"
    user_sees_flash_message "Success"
    expect(page).to have_content @takeaway
  end

  def user_sees_flash_message message
    expect(page).to have_css ".flash", text: message
  end
end
