class Fact < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true
  belongs_to :user
  has_many :links

  after_commit do
    find_and_save_links
  end


  def find_and_save_links
    regexp = /https?:\/\/\w*.[\w\/\-\.]*/ix
    urls = self.description.scan(regexp).to_a
    self.links.destroy_all
    urls.each do |url|
      Link.create(url: url, fact: self)
    end
  end
end
