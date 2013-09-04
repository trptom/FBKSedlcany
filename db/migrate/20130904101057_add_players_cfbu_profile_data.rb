class AddPlayersCfbuProfileData < ActiveRecord::Migration
  def change
    add_column :players, :cfbu_profile_data, :string
  end
end
