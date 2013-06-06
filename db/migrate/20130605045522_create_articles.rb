class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title,              :null => false
      t.text :annotation,           :null => true, :default => nil
      t.text :content,              :null => false
      t.references :user,           :null => false

      t.timestamps
    end
    
    add_index :articles, :user_id
  end
end
