module SignInHelpers
  def sign_in_as_role(user_type)
    user = create(user_type)
    visit root_path(as: user)
  end


end

Rspec.configure do |config|
  config.include SignInHelpers, type: :feature
end