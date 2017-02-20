class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.string :title, default: ""
      t.string :description, default: ""
      t.integer :votes, default: 0
      t.boolean :flagged, default: false
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :facts, :user_id
  end
end
