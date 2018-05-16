class RenameVisibleInRewards < ActiveRecord::Migration[5.2]
  def change
    rename_column :rewards, :visible?, :visible
  end
end
