class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|
      t.string :name, null: false, default: ''
      t.string :shorthand, null: false, default: ''

      t.timestamps
    end
  end
end
