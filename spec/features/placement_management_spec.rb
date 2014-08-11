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

    expect(page).to have_select("Takeaway", selected: takeaway.name)
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

  def user_sees_flash_message message
    expect(page).to have_css ".flash", text: message
  end
end
