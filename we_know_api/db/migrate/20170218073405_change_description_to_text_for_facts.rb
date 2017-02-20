class ChangeDescriptionToTextForFacts < ActiveRecord::Migration
  def up
    change_column_default(:facts, :description, nil)
    change_column :facts, :description, :text
  end
  def down
      # This might cause trouble if you have strings longer
      # than 255 characters.
      change_column :facts, :description, :string
  end
end
