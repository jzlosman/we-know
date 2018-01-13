class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :label
      t.string :description
      t.string :color

      t.timestamps null: false
    end
  end
end
