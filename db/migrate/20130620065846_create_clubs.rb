class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name,       :null => false
      t.string :short_name, :null => false
      t.string :shortcut,   :null => false
      t.string :logo

      t.timestamps
    end
  end
end