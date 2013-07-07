class LeagueTeam < ActiveRecord::Base
  belongs_to :league
  belongs_to :team
  attr_accessible :comment, :position, :position_string, :season
end
