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
    description = "This is a link #{url} in a string."
    fact = FactoryGirl.create(:fact, description: description)
    fact.find_and_save_links
    link = Link.find_by({ fact_id: fact.id })
    assert_equal link.url, url
  end

  test 'when fact is saved, all previous links are destroyed' do
    url = "http://darebee.com/fitness/how-to-recover-from-knee-injury.html"
    fact = FactoryGirl.create(:fact, description: url)
    fact.find_and_save_links
    fact.update({ description: "this is modified #{url}" })
    links = Link.where({ fact_id: fact.id })
    assert_equal links.length, 1
  end
end
