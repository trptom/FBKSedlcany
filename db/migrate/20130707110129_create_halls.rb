class CreateHalls < ActiveRecord::Migration
  def change
    create_table :halls do |t|
      t.string :name,       :null => false
      t.text :description,  :null => true, :default => nil

      t.timestamps
    end
  end
end
