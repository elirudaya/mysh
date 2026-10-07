class CreateChecklists < ActiveRecord::Migration[8.1]
  def change
    create_table :checklists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :country
      t.string :category
      t.text :content

      t.timestamps
    end
  end
end
