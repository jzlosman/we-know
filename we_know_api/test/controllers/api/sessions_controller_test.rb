require 'test_helper'
require 'controllers/test_controller'
class API::SessionsControllerTest < TestController
  test "when logging in, return a valid user credential" do
    password = "12345678"
    user = FactoryGirl.create(:user, password: password, password_confirmation: password)
    credentials = { email: user[:email], password: password }
    post :create, { session: credentials }
    user_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal user[:email], user_response[:email]
  end
  # test "the truth" do
  #   assert true
  # end
end
