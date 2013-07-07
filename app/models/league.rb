class League < ActiveRecord::Base
  has_many :league_teams, dependent: :destroy
  has_many :games, dependent: :destroy

  attr_accessible :group, :level, :name, :short_name, :shortcut
end
