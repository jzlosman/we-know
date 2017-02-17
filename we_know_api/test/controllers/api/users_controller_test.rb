require 'controllers/test_controller'

class Api::UsersControllerTest < TestController
  setup do
    @user = FactoryGirl.create(:user)
  end

  test "show returns a user" do
    get :show, id: @user.id, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal @user.id, result[:id]
  end
end
