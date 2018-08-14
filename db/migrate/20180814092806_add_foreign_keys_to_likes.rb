class AddForeignKeysToLikes < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :likes, :creations
    add_foreign_key :likes, :users
  end
end
