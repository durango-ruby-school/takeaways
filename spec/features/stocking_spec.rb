require 'spec_helper'

feature 'manage racks' do
  background do
    sign_in
  end

  scenario "Add a stocking record for a takeaway" do
    placement=create :placement
    visit placement_path(placement)

    click_link "Add Stocking"
    fill_in "Quantity Stocked", with: 45

    click_button "Create Stocking"
    user_sees_flash_message "Successfully Created"
  end

  scenario "View stocking record on a placement page" do
    placement=create :placement
    stocking=create :stocking, placement: placement

    visit placement_path(placement)

    user_sees_object stocking
  end

  scenario "Ability to edit stocking record quantity" do
    placement=create :placement
    stocking=create :stocking, placement: placement

    visit placement_path(placement)

    click_link "Edit"

    fill_in "Quantity Stocked", with: 9999
    click_button "Update Stocking"

    expect(page).to have_content(9999)
  end
end
