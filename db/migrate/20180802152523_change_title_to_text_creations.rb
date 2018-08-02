class ChangeTitleToTextCreations < ActiveRecord::Migration[5.2]
  def change
    change_column :creations, :title, :text
  end
end
