class AddPublishedToCreations < ActiveRecord::Migration[5.2]
  def change
    add_column :creations, :published?, :boolean, default: false, null: false
  end
end
