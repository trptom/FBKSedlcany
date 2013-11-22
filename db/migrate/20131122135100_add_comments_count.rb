class AddCommentsCount < ActiveRecord::Migration
  def self.up
    add_column :articles, :comments_count, :integer, :null => false, :default => 0
    
    Article.reset_column_information
    Article.find(:all).each do |o|
      Article.update_counters o.id, :comments_count => o.comments.length
    end
  end
  
  def self.down
    remove_column :projects, :comments_count
  end
end
