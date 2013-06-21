class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name,        :null => true, :default => nil
      t.string :short_name,  :null => true, :default => nil
      t.string :shortcut,    :null => true, :default => nil
      t.integer :level,      :null => false, :default => 0
      t.string :logo,        :null => true, :default => nil
      t.references :club,    :null => false

      t.timestamps
    end
    add_index :teams, :club_id
  end
end
