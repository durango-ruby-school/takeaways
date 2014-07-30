require 'spec_helper'

feature 'Placement Management' do

  let(:rack) { create :brochure_rack, number_of_columns: 6, number_of_rows: 6, name: "Rack1" }
  let(:client) { create :client, name: 'Animas Code Labs' }
  let(:takeaway) { create :takeaway, client: client, name:"Summer" }

  scenario "Assign a takeaway to the rack from the rack screen" do
    visit brochure_racks_path

    click_link rack.name
    click_link "Assign Takeaway"

    select takeaway_fullname(client, takeaway), from: 'Takeaway'
    click_button "Assign"

    expect(page).to have_content takeaway_fullname(client, takeaway)
  end

  def takeaway_fullname client, takeaway
    "#{client.name} - #{takeaway.name}"
  end

  scenario "Assign a takeaway to a rack from the takeaway screen" do
    visit takeaways_path

    click_link rack.name
    click_link "Assign Takeaway"

    select takeaway_fullname(client, takeaway), from: 'Takeaway'
    click_button "Assign"

    expect(page).to have_content takeaway_fullname(client, takeaway)
  end

  def takeaway_fullname client, takeaway
    "#{client.name} - #{takeaway.name}"
  end
end
