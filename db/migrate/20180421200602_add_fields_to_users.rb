class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :website_url, :string
    add_column :users, :display_name, :string
  end
end
