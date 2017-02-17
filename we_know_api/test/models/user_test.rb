require 'test_helper'
class UserTest < ActiveSupport::TestCase
  test "user can be created with email address" do
    user = FactoryGirl.create(:user)
    found = User.where({email: user.email})

    assert user.email, found.first.email
  end
  # test "the truth" do
  #   assert true
  # end
end
