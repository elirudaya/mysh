class AddSocialToProfiles < ActiveRecord::Migration[8.1]
  def change
    add_column :profiles, :social, :string
  end
end
