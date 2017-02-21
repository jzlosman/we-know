class FactSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :updated_at
  has_one :user
  has_many :links
end
