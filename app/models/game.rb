class Game < ActiveRecord::Base
  belongs_to :team_home, :class_name => "Team"
  belongs_to :team_away, :class_name => "Team"
  belongs_to :organizer, :class_name => "Team"

  belongs_to :createor, :class_name => "User"
  belongs_to :editor, :class_name => "User"

  belongs_to :league
  belongs_to :place

  serialize :score

  attr_accessible :away_team_id, :home_team_id, :organizer_id, :away_team_, :home_team, :organizer,
      #:creator_id, :editor_id, :creator, :editor, - nepristupuju, nastavujou se automaticky
      :league_id, :place_id, :league, :place,
      :start, :season, :round, :score
end
