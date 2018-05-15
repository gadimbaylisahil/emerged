class ChangePublishedInCreations < ActiveRecord::Migration[5.2]
  def change
    rename_column :creations, :published?, :published
  end
end
