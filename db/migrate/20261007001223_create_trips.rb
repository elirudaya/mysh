class CreateTrips < ActiveRecord::Migration[8.1]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key: true
      t.string :origin_city
      t.string :destination_city
      t.date :start_date
      t.date :end_date
      t.string :trip_type
      t.string :transport

      t.timestamps
    end
  end
end
