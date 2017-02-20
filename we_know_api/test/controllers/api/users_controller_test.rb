require 'controllers/test_controller'

class API::UsersControllerTest < TestController
  # SHOW
  test "show returns a user" do
    user = FactoryGirl.create(:user)
    get :show, id: user.id, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal user.id, result[:id]
    assert_nil result[:auth_token]
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

  test "cannot create a user with a duplicate auth_token" do
    auth_token_test = "abc"
    FactoryGirl.create(:user, auth_token: auth_token_test)
    user = FactoryGirl.create(:user, auth_token: auth_token_test)
    assert_not_equal user.auth_token, auth_token_test
  end

  # UPDATE
  test "when successfully updating user email address" do
    user = FactoryGirl.create :user
    new_email = "new@email.com"
    request.headers['Authorization'] =  user.auth_token
    patch :update, { id: user.id, user: { email: new_email } }, format: :json
    user_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal new_email, user_response[:email]
  end

  test "when unsuccessfully updating user" do
    user = FactoryGirl.create :user
    request.headers['Authorization'] =  user.auth_token
    new_email = "bademail"
    patch :update, { id: user.id, user: { email: new_email } }, format: :json
    user_response = JSON.parse(response.body, symbolize_names: true)
    assert_includes user_response[:errors][:email], "is invalid"
  end

  test "when attempting to update user without Authorization header" do
    user = FactoryGirl.create :user
    new_email = "doesntmatter"
    patch :update, { id: user.id, user: { email: new_email } }, format: :json
    assert_response 401
  end

  # DELETE
  test "when deleting user return a 204" do
    user = FactoryGirl.create :user
    request.headers['Authorization'] =  user.auth_token
    delete :destroy, { id: user.id }, format: :json
    assert_response 204
  end
end
