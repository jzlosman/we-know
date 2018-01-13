class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :category_id
      t.integer :fact_id

      t.timestamps null: false
    end
    
    add_index :groups, :category_id
    add_index :groups, :fact_id
  end
end
