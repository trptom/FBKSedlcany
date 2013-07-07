class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :start,        :null => false
      t.integer :home_team_id,  :null => false
      t.integer :away_team_id,  :null => false
      t.text :score,            :null => true,  :default => nil
      t.integer :hall_id,       :null => true,  :default => nil
      t.integer :organizer_id,  :null => false
      t.integer :league_id,     :null => false
      t.integer :season,        :null => false
      t.integer :round,         :null => true,  :default => nil
      t.integer :creator_id,    :null => false
      t.integer :editor_id,     :null => false

      t.timestamps
    end

    add_index :games, :home_team_id
    add_index :games, :away_team_id
    add_index :games, :hall_id
    add_index :games, :organizer_id
    add_index :games, :league_id
    add_index :games, :season
    add_index :games, :creator_id
    add_index :games, :editor_id
  end
end
