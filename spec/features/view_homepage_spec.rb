require 'spec_helper'

feature "View the homepage" do
  scenario "user sees correct information" do
    visit root_path


    expect(page).to have_title "Takeaways App"
  end
end