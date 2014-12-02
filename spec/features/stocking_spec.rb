require 'spec_helper'

feature 'manage racks' do
  background do
    sign_in
  end

  scenario "Add a stocking record for a takeaway" do
    takeaway = create :takeaway
    rack = create :brochure_rack
    placement = create :placement, takeaway: takeaway, brochure_rack: rack

    visit takeaway_path(takeaway)
    within ".placement" do
      click_link "Add Stocking"
    end
    fill_in "Quantity Stocked", with: 45

    click_button "Create Stocking"
    user_sees_flash_message "Successfully Created"

    visit rack_path(rack)
    within ".placement" do
      click_link "Add Stocking"
    end
    fill_in "Quantity Stocked", with: 45

    click_button "Create Stocking"
    user_sees_flash_message "Successfully Created"
  end

  scenario "Ability to edit stocking record quantity" do
    takeaway = create :takeaway
    placement = create :placement, takeaway: takeaway
    stocking=create :stocking, placement: placement

    visit takeaway_path(takeaway)

    click_link "edit_stocking"
    fill_in "Quantity Stocked", with: 9999
    click_button "Update Stocking"

    expect(page).to have_content(9999)
  end

  scenario "Delete a stocking record" do
    takeaway = create :takeaway
    placement = create :placement, takeaway: takeaway
    stocking=create :stocking, placement: placement

    visit takeaway_path(takeaway)
    click_link "delete_stocking"
    expect(page).to have_content "Successfully Deleted"
  end

  scenario "Filter stockings", js: true do
    takeaway = create :takeaway
    rack = create :brochure_rack
    placement = create :placement, takeaway: takeaway, brochure_rack: rack
    stocking_this_month = create :stocking, placement: placement, stocked_on: Date.today
    stocking_last_month = create :stocking, placement: placement, stocked_on: 1.month.ago

    visit takeaway_path(takeaway)
    user_sees_object stocking_this_month
    user_does_not_see_object stocking_last_month
    select 'Last Month', from: :time_frame
    user_sees_object stocking_last_month
    user_does_not_see_object stocking_this_month

    visit brochure_rack_path(rack)
    user_sees_object stocking_this_month
    user_does_not_see_object stocking_last_month
    select 'Last Month', from: :time_frame
    user_sees_object stocking_last_month
    user_does_not_see_object stocking_this_month
  end

  scenario "Show stocking after placement deletion", js: true do
    takeaway = create :takeaway
    rack = create :brochure_rack
    placement = create :placement, takeaway: takeaway, brochure_rack: rack
    stocking_this_month = create :stocking, placement: placement, stocked_on: Date.today

    placement.destroy

    visit takeaway_path(takeaway)
    user_sees_object stocking_this_month
    select 'Last Month', from: :time_frame
    user_does_not_see_object stocking_this_month

    visit brochure_rack_path(rack)
    user_sees_object stocking_this_month
    select 'Last Month', from: :time_frame
    user_does_not_see_object stocking_this_month
  end

  scenario "Show current placements with stockings for time frame", js: true do
    takeaway = create :takeaway
    rack = create :brochure_rack
    placement_with_stockings_this_month = create :placement, takeaway: takeaway, brochure_rack: rack
    placement_with_stockings_last_month = create :placement, takeaway: takeaway, brochure_rack: rack
    placement_without_stockings = create :placement, takeaway: takeaway, brochure_rack: rack
    stocking_this_month = create :stocking, placement: placement_with_stockings_this_month, stocked_on: Date.today
    stocking_last_month = create :stocking, placement: placement_with_stockings_last_month, stocked_on: 1.month.ago

    placement_with_stockings_this_month.destroy
    placement_with_stockings_last_month.destroy

    visit takeaway_path(takeaway)
    #Default time frame is "This Month"
    #"Show Currently Active Takeaways" should default to true when viewing "This Month"
    user_sees_object placement_without_stockings
    user_sees_object placement_with_stockings_this_month
    user_does_not_see_object placement_with_stockings_last_month

    select 'Last Month', from: :time_frame
    #"Show Currently Active Takeaways" should default to false when viewing "Last Month"
    user_does_not_see_object placement_without_stockings
    user_does_not_see_object placement_with_stockings_this_month
    user_sees_object placement_with_stockings_last_month

    check 'Show Currently Active Takeaways'
    user_sees_object placement_without_stockings
    user_does_not_see_object placement_with_stockings_this_month
    user_sees_object placement_with_stockings_last_month
  end
end
