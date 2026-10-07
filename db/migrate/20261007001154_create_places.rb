class CreatePlaces < ActiveRecord::Migration[8.1]
  def change
    create_table :places do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :city
      t.string :address
      t.string :category

      t.timestamps
    end
  end
end
