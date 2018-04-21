class DropTableCategorizations < ActiveRecord::Migration[5.2]
  def change
    drop_table :categorizations
  end
end
