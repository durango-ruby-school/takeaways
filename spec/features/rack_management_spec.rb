require 'spec_helper'

feature 'manage racks' do
  background do
    sign_in
  end

  scenario 'CRUD for Rack' do
    visit brochure_racks_path

    create_a_rack "Airport"
    user_sees_flash_message "Rack Successfully Created"
    expect(page).to have_content "Airport"

    update_a_rack "DMR"
    user_sees_flash_message "Successfully Updated"
    expect(page).to have_content "DMR"

    click_link "delete_rack"
    expect(page).not_to have_content "DMR"
  end

  def create_a_rack rack_name
    click_link "Add Rack"
    fill_in "Name", with: rack_name
    click_button "Create Rack"
  end

  def update_a_rack rack_name
    click_link "edit_rack"
    fill_in "Name", with: rack_name
    click_button "Update Rack"
  end

  scenario "View list of all takeaways for a rack" do
    rack = create :brochure_rack
    related_placements = create_list :placement, 2,brochure_rack: rack
    unrelated_placement = create :placement

    visit brochure_rack_path(rack)

    user_sees_objects(related_placements)
    user_does_not_see_object(unrelated_placement)
  end
end
