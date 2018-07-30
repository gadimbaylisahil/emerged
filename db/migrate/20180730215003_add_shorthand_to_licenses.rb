class AddShorthandToLicenses < ActiveRecord::Migration[5.2]
  def change
    add_column :licenses, :shorthand, :string
  end
end
