require 'spec_helper'

feature 'manage racks' do
  scenario 'CRUD for Rack' do

    visit brochure_racks_path
    
    click_link "Add Rack"
    fill_in "Name", with: "Airport"
    fill_in "Number of Rows", with: "10"
    fill_in "Number of Columns", with: "4" 
    click_button "Create Rack"
    expect(page).to have_content "Successfully Created"
    
    expect(page).to have_content "Airport"
    click_button "Edit"
    fill_in "Name", with: "DMR"
    fill_in "Number of Rows", with: "8"
    fill_in "Number of Columns", with: "6" 
    click_button "Save Rack"
    expect(page).to have_content "Successfully Updated"
    
    expect(page).to have_content "DMR"
    click_button "Delete"
    expect(page).to have_content "Delete DMR?"
    click_button "Delete"
    expect(page).not_to have_content "DMR"
  end
end