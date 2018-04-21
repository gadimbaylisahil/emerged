class ChangeTypeFieldInRewards < ActiveRecord::Migration[5.2]
  def change
    rename_column :rewards, :type, :reward_type
    rename_column :rewards, :cover_image, :cover_photo
  end
end
