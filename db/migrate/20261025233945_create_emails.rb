class CreateEmails < ActiveRecord::Migration[8.1]
  def change
    create_table :emails do |t|
      t.string :address, null: false
      t.boolean :consent, default: false, null: false
      t.timestamps
    end

    add_index :emails, :address, unique: true
  end
end
