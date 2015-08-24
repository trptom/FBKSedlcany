class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name,       :null => false
      t.text :description,  :null => true, :default => nil
      t.text :code,         :null => false
      t.boolean :active,    :null => false, :default => true

      t.timestamps
    end
    
    add_index :surveys, :active
  end
end
