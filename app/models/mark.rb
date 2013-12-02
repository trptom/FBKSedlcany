class Mark < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  attr_accessible :value, :article, :article_id, :user, :user_id
end
