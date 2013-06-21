class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name,       :null => false
      t.string :second_name,      :null => false
      t.string :nick_name,        :null => true, :default => nil
      t.datetime :birthday,       :null => true, :default => nil
      t.text :note,               :null => true, :default => nil
      t.string :icon,             :null => true, :default => nil
      t.references :team,         :null => true, :default => nil

      t.timestamps
    end

    add_index :players, :team_id
  end
end
