class CreatePlayerStats < ActiveRecord::Migration
  def change
    create_table :player_stats do |t|
      t.integer :player_id,     :null => false
      t.integer :games_played, :null => false, :default => 0
      t.integer :goals,         :null => false, :default => 0
      t.integer :assists,       :null => false, :default => 0
      t.integer :penalty_minutes, :null => false, :default => 0
      t.integer :red_cards_1,   :null => false, :default => 0
      t.integer :red_cards_2,   :null => false, :default => 0
      t.integer :red_cards_3,   :null => false, :default => 0
      t.float :avg_ranking,     :null => true, :default => nil
      t.text :games_descriptor, :null => true, :default => nil
      t.integer :league_id,     :null => false
      t.integer :team_id,       :null => false
      t.integer :season,        :null => false

      t.timestamps
    end

    add_index :player_stats, :player_id
    add_index :player_stats, :team_id
    add_index :player_stats, :league_id
    add_index :player_stats, :season
  end
end
