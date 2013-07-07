class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name,        :null => true, :default => nil
      t.string :short_name,  :null => true, :default => nil
      t.string :shortcut,    :null => true, :default => nil
      t.integer :level,      :null => false, :default => 0
      t.string :logo
      t.integer :club_id,    :null => true, :default => nil

      t.timestamps
    end
    add_index :teams, :club_id
  end
end
