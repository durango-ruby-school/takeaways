require 'spec_helper'

feature 'manage racks' do
  background do
    sign_in
  end


  scenario "Add a stocking record for a takeaway" do
    placement=create :placement
    visit placement_path(placement)

    click_link "Add Stocking"
    fill_in "Date", with: "2011-07-15"
    fill_in "Quanity Stocked", with: 45

    click_button "Create Stocking Record"
    user_sees_flash_message "Successfully Updated"
  end
end
