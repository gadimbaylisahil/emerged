class AddTaxFieldToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :charge_taxes?, :boolean
  end
end
