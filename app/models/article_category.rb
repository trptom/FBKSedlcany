class ArticleCategory < ActiveRecord::Base
  has_and_belongs_to_many :atricles

  attr_accessible :desctiption, :name
end
