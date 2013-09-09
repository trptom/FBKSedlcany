class AddCfbuProfiles < ActiveRecord::Migration
  def change
    add_column :teams, :cfbu_profile_data, :string
    add_column :leagues, :cfbu_profile_data, :string
    add_column :games, :cfbu_profile_data, :string
  end
end
