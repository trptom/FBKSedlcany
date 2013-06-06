class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  belongs_to :comment
  has_many :comments
  
  attr_accessible :content, :title, :user, :user_id, :article, :article_id, :comment, :comment_id

  validates :content,
    :length => { :minimum => 1, :message => VALIDATION_ERROR_MESSAGE["comment"]["content"] }

  validates :user_id,
    :presence => { :message => VALIDATION_ERROR_MESSAGE["comment"]["user_id"] },
    :numericality => { :only_integer => true, :greater_than => 0, :message => VALIDATION_ERROR_MESSAGE["comment"]["user_id"] }
  validates :user, :associated => { :message => VALIDATION_ERROR_MESSAGE["comment"]["user_id"] }

#  validates :article_id,
#    :presence => { :message => VALIDATION_ERROR_MESSAGE["comment"]["article_id"] },
#    :numericality => { :only_integer => true, :greater_than => 0, :message => VALIDATION_ERROR_MESSAGE["comment"]["article_id"] },
#    :allow_nil => true,
#    :allow_blank => true
#  validates :article, :associated => { :message => VALIDATION_ERROR_MESSAGE["comment"]["article_id"] },
#    :if => :article
end
