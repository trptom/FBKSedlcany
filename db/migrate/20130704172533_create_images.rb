class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name,           :null => false
      t.text :description,      :null => true
      t.string :logical_folder, :null => false, :default => ""
      t.string :image,          :null => false
      t.references :user,       :null => false

      t.timestamps
    end
    add_index :images, :user_id
  end
end
