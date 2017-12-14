class CreateSupporterProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :supporter_profiles do |t|
      t.references :user, foreign_key: true, index: true
      t.string :first_name
      t.string :last_name
      t.text :avatar
      t.text :about
      t.text :title
      t.string :username

      t.timestamps
    end
  end
end
