class AddFieldsToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :cover_image, :text
    add_column :rewards, :title, :string
    add_column :rewards, :description, :text
    add_column :rewards, :type, :string
    add_column :rewards, :visible?, :boolean, default: false, null: false
  end
end
