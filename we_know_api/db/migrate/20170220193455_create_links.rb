class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :image
      t.integer :fact_id

      t.timestamps null: false
    end
    
    add_index :links, :fact_id
  end
end
