class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.references :article, :null => false
      t.references :user,    :null => false
      t.integer :value,      :null => false

      t.timestamps
    end
    add_index :marks, :article_id
    add_index :marks, :user_id
  end
end
