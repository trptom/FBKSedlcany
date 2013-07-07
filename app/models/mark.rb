class Mark < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  attr_accessible :value
end
