class ReplaceStatusWithIsPaidInSupports < ActiveRecord::Migration[5.2]
  def change
    remove_column :supports, :status
    add_column :supports, :is_paid, :boolean, default: false, null: false
  end
end
