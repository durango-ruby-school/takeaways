require 'spec_helper'

feature "Client Management" do
  scenario "User Manages Clients" do
    visit root_path
    click_link "Clients"
    click_link "New Client"
    fill_in  "Name", :with => "Durango Space"
    click_button "Create"
    expect(page).to have_content "Successfully"
  end
end

















