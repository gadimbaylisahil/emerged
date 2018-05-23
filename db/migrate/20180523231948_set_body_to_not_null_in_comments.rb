class SetBodyToNotNullInComments < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :body, :text, null: false, default: ''
  end
end
