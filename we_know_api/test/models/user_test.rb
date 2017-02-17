require 'test_helper'
class UserTest < ActiveSupport::TestCase
  test "user can be created with email address" do
    email = FFaker::Internet.email
    user = FactoryGirl.create(:user, email: email)
    found = User.where({email: email})
    assert user.email, found.first.email
  end
  # test "the truth" do
  #   assert true
  # end
end
