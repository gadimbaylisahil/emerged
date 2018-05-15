class AdjustUserTableForDevise < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :remember_token
    remove_column :users, :email
    remove_column :users, :encrypted_password
    remove_column :users, :remember_token

    add_column :users, :email, :string, null: false, default: '', index: true
    add_column :users, :encrypted_password, :string, null: false, default: ''

    #Recoverable
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime

    #Rememberable
    add_column :users, :remember_created_at, :string

    #Trackable
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :inet
    add_column :users, :last_sign_in_ip, :inet

    #confirmable
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
  end
end
