class AddStatusToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :status, :string, default: "pending", null: false
  end
end
