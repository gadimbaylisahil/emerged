class AddPersonalFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :company, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :about_me, :text
    add_column :users, :title, :string
  end
end
