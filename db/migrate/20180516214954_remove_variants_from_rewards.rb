class RemoveVariantsFromRewards < ActiveRecord::Migration[5.2]
  def change
    remove_column :rewards, :variants
  end
end
