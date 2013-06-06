class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title,       :null => true, :default => nil
      t.text :content,       :null => false
      t.references :user,    :null => false
      t.references :article, :null => true, :default => nil
      t.references :comment, :null => true, :default => nil

      t.timestamps
    end
    
    add_index :comments, :user_id
    add_index :comments, :article_id
    add_index :comments, :comment_id
  end
end
