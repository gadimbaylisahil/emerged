class DropTableCreationsCategories < ActiveRecord::Migration[5.1]
  def change
    drop_table :categories_creations
  end
end
