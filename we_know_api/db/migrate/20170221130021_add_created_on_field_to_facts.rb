class AddCreatedOnFieldToFacts < ActiveRecord::Migration
  def change
    add_column :facts, :created_on, :date
  end
end
