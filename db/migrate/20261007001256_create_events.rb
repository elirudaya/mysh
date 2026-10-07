class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :date
      t.string :city
      t.integer :capacity

      t.timestamps
    end
  end
end
