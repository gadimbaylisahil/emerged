class AddUserDetailsFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :avatar, :text
    add_column :users, :about, :text
    add_column :users, :profession, :string
    add_column :users, :title, :string
    add_column :users, :username, :string
  end
end
