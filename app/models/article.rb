class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :atricle_categories
  has_many :comments
  
  attr_accessible :annotation, :content, :title, :comments, :user, :atricle_categories

  def comments_count
    return comments.count
  end
end
