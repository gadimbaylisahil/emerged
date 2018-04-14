class AddVisitorCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :number_of_visitors, :bigint, default: 0, null: false
  end
end
