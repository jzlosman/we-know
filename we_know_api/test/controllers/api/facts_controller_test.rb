require 'test_helper'

class API::FactsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  # SHOW
  test "show returns a fact" do
    fact = FactoryGirl.create(:fact)
    get :show, id: fact.id, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal fact.id, result[:id]
  end

  test "index should return list of facts" do
    4.times { FactoryGirl.create :fact }
    get :index, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal Fact.all.length, result.length
  end

  test "create should create a new fact" do
    user = FactoryGirl.create(:user)
    request.headers['Authorization'] =  user.auth_token
    fact = FactoryGirl.attributes_for :fact
    post :create, { user_id: user.id, fact: fact }, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal result[:title], fact[:title], "name should match on create"
  end

  test "update should change a fact" do
    user = FactoryGirl.create(:user)
    fact = FactoryGirl.create(:fact, user: user)
    title = FFaker::Lorem.sentence
    request.headers['Authorization'] =  user.auth_token
    patch :update, { user_id: user.id, id: fact.id, fact: { title: title } }, format: :json
    result = JSON.parse(response.body, symbolize_names: true)
    assert_equal result[:title], title, "name should match on update"
  end
end
