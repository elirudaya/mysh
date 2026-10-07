class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :origin_country
      t.string :origin_city
      t.string :current_country
      t.string :current_city

      t.timestamps
    end
  end
end
