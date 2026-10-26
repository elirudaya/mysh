class AddAgeToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_column :profiles, :age, :integer
  end
end
