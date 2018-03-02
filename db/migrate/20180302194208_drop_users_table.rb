class DropUsersTable < ActiveRecord::Migration[5.1]
  def change
    remove_index :creations, name: "index_creations_on_user_id"
    remove_index :profiles, name: "index_profiles_on_user_id"
    remove_column :profiles, :user_id
    remove_column :creations, :user_id
    drop_table :users
  end
end
