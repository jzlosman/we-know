class Group < ActiveRecord::Base
  belongs_to :fact
  belongs_to :category

  #scope :categoriesByUser, ->(id) {
  #  joins(:fact)
  #  .joins(:category)
  #  .group(:category_id)
  #  .where({facts: {user_id: id}})
  #}
end
