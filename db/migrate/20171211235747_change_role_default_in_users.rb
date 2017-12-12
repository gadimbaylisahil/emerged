class ChangeRoleDefaultInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role, :string, :null => false, default: 'supporter'
  end
end
