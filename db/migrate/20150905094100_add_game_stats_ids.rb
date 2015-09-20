class AddGameStatsIds < ActiveRecord::Migration
  def change
    add_column :games, :player_stats, :text, :null => true, :default => nil
  end
end
