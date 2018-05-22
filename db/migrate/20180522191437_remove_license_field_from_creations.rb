class RemoveLicenseFieldFromCreations < ActiveRecord::Migration[5.2]
  def change
    remove_column :creations, :license
  end
end
