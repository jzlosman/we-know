class Fact < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true
  belongs_to :user
end
