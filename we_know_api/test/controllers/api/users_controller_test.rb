require 'controllers/test_controller'

class API::UsersControllerTest < TestController
  # SHOW
  test "show returns a user" do
    user = FactoryGirl.create(:user)
    get :show, id: user.id, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal user.id, result[:id]
  end

  # CREATE
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
    assert_includes user_response[:errors][:email], "can't be blank"
  end

  # UPDATE
  test "when successfully updating user" do
    user = FactoryGirl.create :user
    new_email = "new@email.com"
    patch :update, { id: user.id, user: { email: new_email } }, format: :json
    user_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal user_response[:email], new_email
  end

  test "when unsuccessfully updating user" do
    user = FactoryGirl.create :user
    new_email = "bademail"
    patch :update, { id: user.id, user: { email: new_email } }, format: :json
    user_response = JSON.parse(response.body, symbolize_names: true)
    assert_includes user_response[:errors][:email], "is invalid"
  end

  # DELETE
  test "when deleting user return a 204" do
    user = FactoryGirl.create :user
    delete :destroy, { id: user.id }, format: :json
    assert_response 204
  end
end
