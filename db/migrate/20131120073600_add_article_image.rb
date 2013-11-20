class AddArticleImage < ActiveRecord::Migration
  def change
    add_column :articles, :image, :string, :null => true, :default => nil
  end
end
