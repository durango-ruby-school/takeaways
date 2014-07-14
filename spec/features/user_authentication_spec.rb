require 'spec_helper'

feature 'user authentication' do

  scenario 'unauthenicated access attempt' do
    visit root_path
    user_sees_sign_in_form
  end

  def user_sees_sign_in_form
    expect(page).to have_css("[data-role=sign-in-form]")
  end
end
