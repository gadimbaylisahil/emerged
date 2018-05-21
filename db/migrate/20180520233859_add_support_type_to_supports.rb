class AddSupportTypeToSupports < ActiveRecord::Migration[5.2]
  def change
    add_column :supports, :support_type, :string, default: 'one_time', null: false
  end
end
