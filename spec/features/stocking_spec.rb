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

    click_link "edit_stocking"
    fill_in "Quantity Stocked", with: 9999
    click_button "Update Stocking"

    expect(page).to have_content(9999)
  end

  scenario "Delete a stocking record" do
    placement=create :placement
    stocking=create :stocking, placement: placement

    visit placement_path(placement)
    click_link "delete_stocking"
    expect(page).to have_content "Successfully Deleted"
  end

  scenario "Filter Stockings" do
    placement=create :placement
    stocking_this_month = create :stocking, placement: placement, stocked_on: Date.today
    stocking_last_month = create :stocking, placement: placement, stocked_on: 1.month.ago

    visit placement_path(placement)
    user_sees_object stocking_this_month
    user_does_not_see_object stocking_last_month

    select 'Last Month', from: :time_frame
    user_sees_object stocking_last_month
    user_does_not_see_object stocking_this_month
  end
end
