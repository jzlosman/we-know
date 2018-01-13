class FactSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at,
              :votes
  has_one :user
  has_many :links, excludes: [:show]
  has_many :categories, through: :groups
  def votes
    object.votes.size
  end
end
