class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :atricle_categories
  has_many :comments
  
  attr_accessible :annotation, :content, :title, :comments, :user, :atricle_categories

  scope :most_commented, ->(limit = ARTICLES_LIST_PAGE_LIMIT) {
    select("articles.*, COUNT(comments.id) AS comments")
        .joins("LEFT OUTER JOIN comments ON articles.id = comments.article_id")
        .group("articles.id")
        .order("comments DESC")
        .limit(limit)
  }

  def comments_count
    return comments.count
  end
end
