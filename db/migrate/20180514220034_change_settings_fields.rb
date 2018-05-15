class ChangeSettingsFields < ActiveRecord::Migration[5.2]
  def change
    rename_column :settings, :email_likes?, :receive_emails_for_likes
    rename_column :settings, :email_follows?, :receive_emails_for_follows
    rename_column :settings, :emerged_emails?, :receive_emails_from_emerged
  end
end
