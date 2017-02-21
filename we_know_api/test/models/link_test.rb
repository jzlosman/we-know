require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'link is created and added to fact' do
    url = "http://darebee.com/fitness/casual-training.html"
    fact = FactoryGirl.create(:fact)
    link = FactoryGirl.create(:link, fact: fact, url: url)
    assert_equal link.title, "Casual Training"
  end

  test 'when fact is updated, links are created' do
    url = "http://darebee.com/fitness/how-to-recover-from-knee-injury.html"
    description = url
    fact = FactoryGirl.create(:fact, description: description)
    fact.find_and_save_links
    link = Link.find_by({ fact_id: fact.id })
    puts link.inspect
    assert_equal link.url, url
  end
end
