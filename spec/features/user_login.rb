require 'spec_helper'

feature 'Authentication' do
  scenario 'Sign In' do
    FactoryGirl.create :user, email: "joesmith@example.com", password: "password"
    
    visit sign_in_path
    fill_in "Email", with: "joesmith@example.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    expect(page).to have_content "Welcome joesmith@example.com"
    
    click_link "Sign out"
    expect(page).to have_content "Sign in"
  end
end