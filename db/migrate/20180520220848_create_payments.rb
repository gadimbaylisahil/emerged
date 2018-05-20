class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :support, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.integer :amount_cents
      t.string :status

      t.timestamps
    end
  end
end
