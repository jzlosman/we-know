class Fact < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true
  validate :only_one_fact_per_day
  belongs_to :user
  has_many :links

  scope :today, lambda { where(created_on: Date.today) }
  scope :byUser, lambda { |user_id|
    where(user_id: user_id)
  }

  after_commit do
    find_and_save_links
  end

  def only_one_fact_per_day
    if Fact.byUser(user_id).today.all.length > 0
      errors.add(:created_on, "Only one fact per day.")
    end
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
