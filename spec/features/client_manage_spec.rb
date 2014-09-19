require 'spec_helper'

feature "Client Management" do
  background do
    sign_in
  end

  scenario "User Manages Clients" do
    visit root_path
    within ".navigation" do
      click_link "Clients"
    end
    click_link "New Client"
    fill_in  "Name", :with => "Durango Space"
    click_button "Create"
    expect(page).to have_content "Successfully Created"

    click_link "edit_client"
    fill_in "Name", :with => "Animas Code Labs"
    click_button "Update Client"
    expect(page).to have_content "Successfully Updated"

    click_link "delete_client"
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

  scenario "Add Takeaway From Clients Page" do
    client= create :client, name: 'DMR'

    visit clients_path
    click_link "DMR"
    click_link 'Add Takeaway'
    fill_in "Name", with: "Spring special"
    click_button "Create Takeaway"

    user_sees_flash_message /success/i
  end
end
