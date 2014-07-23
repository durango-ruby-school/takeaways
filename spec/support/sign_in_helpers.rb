module SignInHelpers
  def sign_in_as_role(user_type)
    user = create(user_type)
    visit root_path(as: user)
  end

  def sign_in
    sign_in_as_role(:user)
  end


end

RSpec.configure do |config|
  config.include SignInHelpers, type: :feature
end
