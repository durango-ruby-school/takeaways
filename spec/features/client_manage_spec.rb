require 'spec_helper'

feature "Client Management" do
  background do
    sign_in
  end

  scenario "User Manages Clients" do
    visit_new_client_page

    fill_out_new_client_form_with_name "Durango Space"

    user_sees_flash_message "Successfully Created"

    edit_client_name "Animas Code Labs"
    user_sees_flash_message "Successfully Updated"

    delete_client

    user_sees_flash_message "Deleted"
    user_sees_page_title "Clients"
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

  def visit_new_client_page
    visit root_path
    within ".navigation" do
      click_link "Clients"
    end
    click_link "New Client"
  end

  def fill_out_new_client_form_with_name name
    fill_in "Name", :with => name
    fill_in "Contact", :with => "Aaron Renner"
    fill_in "Street", :with => "123 Main Ave"
    fill_in "City", :with => "Durango"
    fill_in "State", :with => "CO"
    fill_in "Zip", :with => "81301"
    fill_in "Phone", :with  => "970-555-1234"
    fill_in "Email", :with => "Aaron@animascodelabs.com"
    click_button "Create"
  end

  def edit_client_name name
    click_link "edit_client"
    fill_in "Name", :with => "Animas Code Labs"
    click_button "Update Client"
  end

  def delete_client
    click_link "delete_client"
  end

  def user_sees_page_title title
    expect(page).to have_content title
  end
end
