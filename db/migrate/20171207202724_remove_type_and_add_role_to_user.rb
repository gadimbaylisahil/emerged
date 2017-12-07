class RemoveTypeAndAddRoleToUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :type
    add_column :users, :role, :integer, default: 1, allow_null: false
  end
end
