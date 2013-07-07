class CreateLeagueTeams < ActiveRecord::Migration
  def change
    create_table :league_teams do |t|
      t.references :league,       :null => false
      t.references :team,         :null => false
      t.integer :season,          :null => false
      t.integer :position,        :null => true, :default => nil
      t.string :position_string,  :null => true, :default => nil
      t.text :comment,            :null => true, :default => nil

      t.timestamps
    end
    add_index :league_teams, :league_id
    add_index :league_teams, :team_id
  end
end
