class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.string :name
      t.text :desctiption

      t.timestamps
    end
  end
end
