class AddNumberOfSharesToCreations < ActiveRecord::Migration[5.2]
  def change
    add_column :creations, :number_of_shares, :integer, default: 0, null: false
  end
end
