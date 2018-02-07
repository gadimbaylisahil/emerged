class AddContenToCreations < ActiveRecord::Migration[5.1]
  def change
    add_column :creations, :content, :text
  end
end
