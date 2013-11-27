class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name,       :null => false
      t.text :description,  :null => true, :default => nil
      t.datetime :start,    :null => false
      t.datetime :end,      :null => false

      t.timestamps
    end
  end
end
