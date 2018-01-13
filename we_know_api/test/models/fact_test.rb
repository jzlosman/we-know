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

  test 'get facts from a specific category' do
    category_one = FactoryGirl.create(:category, label: "Fitness", description: "Fitness and stuff")
    category_two = FactoryGirl.create(:category, label: "Nutrition", description: "Food and stuff")
    FactoryGirl.create(:fact, categories: [category_one])
    FactoryGirl.create(:fact, categories: [category_one])
    FactoryGirl.create(:fact, categories: [category_one])
    FactoryGirl.create(:fact, categories: [category_two])
    FactoryGirl.create(:fact, categories: [category_one, category_two])
    fitness_facts = Fact.by_categories([category_one.id]).all
    assert_equal fitness_facts.length, 4
    fitness_facts = Fact.by_categories([category_one.id, category_two.id]).all
    assert_equal fitness_facts.length, 5
  end
end
