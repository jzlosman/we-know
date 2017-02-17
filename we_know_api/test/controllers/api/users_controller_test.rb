require 'controllers/test_controller'

class API::UsersControllerTest < TestController
  test "show returns a user" do
    user = FactoryGirl.create(:user)
    get :show, id: user.id, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal user.id, result[:id]
  end

  test "when user is successfully created, render the user" do
    user = FactoryGirl.attributes_for :user
    post :create, { user: user }, format: :json
    user_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal user[:email], user_response[:email]
  end

  test "when user is unsuccessfully created, render an error" do
    bad_user = {password: "1234"}
    post :create, { user: bad_user }, format: :json

    user_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal user_response[:errors][:email][0], "can't be blank"
  end
end
