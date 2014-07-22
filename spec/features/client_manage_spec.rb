require 'spec_helper'

feature "Client Management" do
  scenario "User Manages Clients" do
    visit root_path
    click_link "Clients"
    click_link "New Client"
    fill_in  "Name", :with => "Durango Space"
    click_button "Create"
    expect(page).to have_content "Successfully Created"

    click_link "Edit"
    fill_in "Name", :with => "Animas Code Labs"
    click_button "Update Client"
    expect(page).to have_content "Successfully Updated"

    click_link "Delete"
    expect(page).to have_content "Deleted"
    expect(page).to have_content "Clients"
  end

  scenario "View Client Takeaways" do
    client= create :client, name: 'DMR'
    create :takeaway, client: client, name: "Summer"
    create :takeaway, client: client, name: "Winter"
    
    visit clients_path
    click_link 'DMR'

    expect(page).to have_content "Summer"
    expect(page).to have_content "Winter"
  end
end
