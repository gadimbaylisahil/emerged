class CreateSplitPurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :split_purchases do |t|
      t.references :purchase, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
