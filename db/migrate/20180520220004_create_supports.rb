class CreateSupports < ActiveRecord::Migration[5.2]
  def change
    create_table :supports do |t|
      t.string :supportable_type
      t.integer :supportable_id
      t.integer :amount_cents
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
