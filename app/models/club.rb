class Club < ActiveRecord::Base
  attr_accessible :logo, :name, :short_name, :shortcut
  has_many :teams
end
