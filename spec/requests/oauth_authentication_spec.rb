require 'spec_helper'

describe "oauth authentication" do
  it "returns a token with the correct email and password" do
    user = create :user

    post "/oauth/token", grant_type: "password", email: user.email, password: user.password

    expect(response.status).to eq(200)

    response_json = JSON.parse response.body
    expect(response_json).to have_key("access_token")
  end

  it "returns a 401 status with the incorrect email and password" do
    user = create :user

    post "/oauth/token", grant_type: "password", email: user.email, password: "invalid"

    expect(response.status).to eq(401)

    response_json = JSON.parse response.body
    expect(response_json).not_to have_key("access_token")
  end
end
