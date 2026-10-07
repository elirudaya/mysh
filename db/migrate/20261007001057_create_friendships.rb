class CreateFriendships < ActiveRecord::Migration[8.1]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: true
      t.string :friend_email
      t.string :status

      t.timestamps
    end
  end
end
