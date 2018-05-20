class AddPaymentToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :payment, foreign_key: true, index: true
  end
end
