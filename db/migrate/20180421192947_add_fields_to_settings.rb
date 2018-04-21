class AddFieldsToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :email_likes?, :boolean, default: true, null: false
    add_column :settings, :email_follows?, :boolean, default: true, null: false
    add_column :settings, :emerged_emails?, :boolean, default: true, null: false
  end
end
