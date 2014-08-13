module FlashMessageHelpers
  def user_sees_flash_message message
    expect(page).to have_css ".flash", text: message
  end
end

RSpec.configure do |config|
  config.include FlashMessageHelpers, type: :feature
end
