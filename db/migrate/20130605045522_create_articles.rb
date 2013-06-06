class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :annotation
      t.text :content
      t.references :user
      t.references :articleCategory

      t.timestamps
    end
    
    add_index :articles, :user_id
  end
end
