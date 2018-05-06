class ChangeFieldsInActivities < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :name, :activity_type
    remove_column :activities, :direction
  end
end
