class AddFieldsToCreations < ActiveRecord::Migration[5.1]
  def change
    add_column :creations, :cover_image, :text
    add_column :creations, :title, :string
  end
end
