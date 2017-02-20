require 'test_helper'

class FactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'fact is created with attrs' do
    title = "Big muscles aren't the same as strong muscles"
    user = FactoryGirl.create(:user)
    fact = FactoryGirl.create(:fact, title: title, user: user)
    assert_equal title, fact.title, "Title should be what we sent along"
  end
end
