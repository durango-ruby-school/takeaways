require 'spec_helper'

feature 'manage racks' do
  scenario 'CRUD for Rack' do

    visit brochure_racks_path
    
    create_a_rack "Airport"
    user_sees_flash_message "Rack Successfully Created"
    expect(page).to have_content "Airport"    
    
    update_a_rack "DMR"
    user_sees_flash_message "Successfully Updated"
    expect(page).to have_content "DMR"
    
    click_link "Delete"
    expect(page).not_to have_content "DMR"
  end
  
  def create_a_rack rack_name
    click_link "Add Rack"
    fill_in "Name", with: rack_name
    fill_in "Number of Rows", with: "10"
    fill_in "Number of Columns", with: "4"     
    click_button "Create Rack"
  end
  
  def update_a_rack rack_name
    click_link "Edit"
    fill_in "Name", with: rack_name
    fill_in "Number of Rows", with: "8"
    fill_in "Number of Columns", with: "6"     
    click_button "Update Rack"
  end
  
  def user_sees_flash_message message
    expect(page).to have_css ".flash", text: message
  end
end