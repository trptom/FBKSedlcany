class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :atricle_categories
  
  attr_accessible :annotation, :content, :title
end
