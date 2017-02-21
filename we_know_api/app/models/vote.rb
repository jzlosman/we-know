class Vote < ActiveRecord::Base
  validates :fact_id, :user_id, presence: true
  validate :only_one_vote
  belongs_to :fact
  belongs_to :user

  scope :byUser, lambda { |user_id|
    where(user_id: user_id)
  }
  scope :byFact, lambda { |fact_id|
    where(fact_id: fact_id)
  }

  def only_one_vote
    if Vote.byFact(fact_id).byUser(user_id).all.length > 0
      errors.add(:user_id, "Only one vote per user.")
    end
  end
end
