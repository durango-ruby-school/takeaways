require 'spec_helper'

feature 'manage racks' do
  background do
    sign_in
  end


  scenario "Add a stocking record for a takeaway" do
    placement=create :placement
    visit placement_path(placement)
    
    click_link "Add Stocking"
    #select "2013", from: "stocking_stocked_on_1i"
    fill_in "Quantity Stocked", with: 45

    click_button "Create Stocking"
    user_sees_flash_message "Successfully Updated"
  end
end
