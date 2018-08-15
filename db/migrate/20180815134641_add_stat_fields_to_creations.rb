class AddStatFieldsToCreations < ActiveRecord::Migration[5.2]
  def change
    rename_column :creations, :number_of_shares, :shares_count
    add_column :creations, :likes_count, :integer, default: 0, null: false
    add_column :creations, :comments_count, :integer, default: 0, null: false
  end
end
