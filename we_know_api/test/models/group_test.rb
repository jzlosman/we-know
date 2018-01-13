require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test 'create a group with category and fact' do
    fact = FactoryGirl.create(:fact)
    category = FactoryGirl.create(:category, label: "Entertainment", description: "Related to movies, tv and comics.")
    group = Group.new(fact: fact, category: category)
    group.save!
    assert_equal fact.groups.all.first.category.label, "Entertainment"
  end
  # test "the truth" do
  #   assert true
  # end
end
