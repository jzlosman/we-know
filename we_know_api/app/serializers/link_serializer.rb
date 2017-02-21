class LinkSerializer < ActiveModel::Serializer
  attributes :title, :description, :image, :url, :created_at, :updated_at
  has_one :fact
end
