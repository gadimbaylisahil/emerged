class RenameOrdersTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :orders, :purchases
  end
end
