class AddCreatedOnFieldToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :created_on, :date
  end
end
