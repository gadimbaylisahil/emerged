class AddVariantsToRewards < ActiveRecord::Migration[5.2]
  def change
    add_column :rewards, :variants, :jsonb, null: false, default: {}
    add_index :rewards, :variants, using: :gin
  end
end
