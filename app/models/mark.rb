class Mark < ActiveRecord::Base
  belongs_to :article, dependent: :destroy
  belongs_to :user, dependent: :destroy
  attr_accessible :value
end
