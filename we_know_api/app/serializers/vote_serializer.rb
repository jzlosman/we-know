class VoteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :fact_id
end
