class AddStatusToSupports < ActiveRecord::Migration[5.2]
  def change
    add_column :supports, :status, :string, status: 'unpaid', null: false
  end
end
