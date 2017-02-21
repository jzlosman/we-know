require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "can add a vote" do
    user = FactoryGirl.create(:user)
    fact = FactoryGirl.create(:fact, user: user)
    vote = FactoryGirl.create(:vote, user: user, fact: fact)
    assert_equal vote.user[:id], user[:id]
    assert_equal vote.fact[:id], fact[:id]
  end

  test "can find votes for fact" do
    user = FactoryGirl.create(:user)
    fact = FactoryGirl.create(:fact)
    vote = FactoryGirl.create(:vote, user: user, fact: fact)
    assert_equal vote[:id], Vote.byFact(fact[:id]).all.first[:id]
  end

  test "cannot vote twice" do
    user = FactoryGirl.create(:user)
    fact = FactoryGirl.create(:fact, user: user)
    attrs = FactoryGirl.attributes_for :vote, user:user, fact: fact
    Vote.create(attrs)
    vote = Vote.create(attrs)
    refute vote.valid?
  end
end
