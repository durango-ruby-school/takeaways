FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    token { SecureRandom.hex(10) }
  end
end
