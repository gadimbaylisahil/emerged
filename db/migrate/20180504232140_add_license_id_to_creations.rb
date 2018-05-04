class AddLicenseIdToCreations < ActiveRecord::Migration[5.2]
  def change
    add_column :creations, :license_id, :integer
  end
end
