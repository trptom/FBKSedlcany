class Team < ActiveRecord::Base
  mount_uploader :logo, TeamLogoUploader

  belongs_to :club, :class_name => 'Team'
  has_many :teams, :class_name => 'Team', :foreign_key => 'club_id'
  
  has_many :players
  has_many :league_teams, dependent: :destroy

  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id'
  def games
    home_games + away_games
  end

  has_many :organized_games, :class_name => 'Game', :foreign_key => 'organizer_id'

  attr_accessible :level, :logo, :logo_cache, :name, :short_name, :shortcut, :club, :club_id

  def is_club
    return level == 0 && id == club_id
  end

  def is_team
    return level > 0 || id != club_id
  end

  ##############################################################################

  scope :clubs, -> {
    where(:level => 0, :id => :club_id)
  }

  scope :teams, -> {
    where("(level > 0) OR (id != club_id)")
  }

  def logo_image(type = :full)
    url = logo_url(type)
    return url != nil && url != "" ? ActionController::Base.helpers.image_tag(url) : nil
  end

  def self.get_club_options(atts)
    if (atts[:where])
      res = Team.clubs.where(atts[:where])
    else
      res = Team.clubs;
    end

    if (atts[:order_by])
      res = res.order(atts[:order_by])
    end

    ary = Array.new
    if (atts[:empty])
      ary << [ I18n.t("messages.base.no_team"), "" ]
    end
    res.all.each do |item|
      ary << [item.name, item.id];
    end

    return ary;
  end
end
