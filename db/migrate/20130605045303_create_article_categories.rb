class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.string :name,      :null => false
      t.text :desctiption, :null => true, :default => nil

      t.timestamps
    end
  end
end
