require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create a category" do
    category = Category.new(label: "Test", description: "description test")
    assert_equal category.label, "Test"
  end

  test "fetch a category" do
    category = Category.new(label: "Test", description: "description test")
    category.save!
    found_category = Category.find(category.id)
    assert_equal category.id, found_category.id
  end
end
