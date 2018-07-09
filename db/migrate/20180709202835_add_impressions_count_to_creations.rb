class AddImpressionsCountToCreations < ActiveRecord::Migration[5.2]
  def change
    add_column :creations, :impressions_count, :integer, default: 0, null: false
  end
end
