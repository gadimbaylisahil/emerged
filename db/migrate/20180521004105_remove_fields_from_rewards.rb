class RemoveFieldsFromRewards < ActiveRecord::Migration[5.2]
  def change
    remove_column :rewards, :reward_type
    remove_reference :rewards, :category
    remove_column :rewards, :charge_taxes?
  end
end
