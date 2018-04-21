class AddCategoryToCreations < ActiveRecord::Migration[5.2]
  def change
    add_reference :creations, :category, index: true, foreign_key: true
  end
end
