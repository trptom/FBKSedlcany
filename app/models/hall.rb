class Hall < ActiveRecord::Base
  has_many :games

  attr_accessible :description, :name
end
