require 'test_helper'

class API::VotesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "can vote for a fact" do
    fact = FactoryGirl.create(:fact)
    user = FactoryGirl.create(:user)
    request.headers['Authorization'] =  user.auth_token
    post :create, { fact_id: fact.id }, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal result[:user_id], user[:id]
    assert_equal result[:fact_id], fact[:id]
  end

  test "cannot vote for a fact twice" do
    fact = FactoryGirl.create(:fact)
    user = FactoryGirl.create(:user)
    request.headers['Authorization'] =  user.auth_token
    post :create, { fact_id: fact.id }, format: :json
    post :create, { fact_id: fact.id }, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal result[:status], 422
  end

  test "can delete vote" do
    fact = FactoryGirl.create(:fact)
    user = FactoryGirl.create(:user)
    vote = FactoryGirl.create(:vote, fact: fact, user: user)
    request.headers['Authorization'] =  user.auth_token
    delete :destroy, { id: vote[:id] }, format: :json
    assert_response 204
  end
end
