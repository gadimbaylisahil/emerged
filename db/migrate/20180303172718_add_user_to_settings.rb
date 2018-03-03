class AddUserToSettings < ActiveRecord::Migration[5.1]
  def change
  	add_reference :settings, :user, foreign_key: true, index: true
	end
end
