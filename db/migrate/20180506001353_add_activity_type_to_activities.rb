class AddActivityTypeToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :is_public, :boolean, default: false, null: false
  end
end
