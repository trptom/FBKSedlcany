class Team < ActiveRecord::Base
  mount_uploader :logo, TeamLogoUploader

  belongs_to :club, :class_name => 'Team'
  has_many :teams, :class_name => 'Team', :foreign_key => 'club_id'
  
  has_many :players
  has_many :league_teams, dependent: :destroy

  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id'

  has_many :organized_games, :class_name => 'Game', :foreign_key => 'organizer_id'

  attr_accessible :level, :logo, :logo_cache, :name, :short_name, :shortcut, :club, :club_id

  def is_club
    logger.info "xxxxxxxxxxxxxxxx"
    logger.info "level: " + level.to_s
    logger.info "id: " + id.to_s
    logger.info "club_id: " + club_id.to_s
    return level == 0 && id == club_id
  end

  def is_team
    return level > 0 || id != club_id
  end

  def logo_image(type = :full)
    url = logo_url(type)
    return url != nil && url != "" ? ActionController::Base.helpers.image_tag(url) : nil
  end

  def games
    home_games + away_games
  end

  def squad
    if is_team
      return players
    else
      list = []
      for team in teams
        list = list + team.players
      end
      return list.uniq
    end
  end

  ##############################################################################

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

  ##############################################################################

  scope :clubs, -> {
    where("(level = 0) AND (id = club_id)")
  }

  scope :teams, -> {
    where("(level > 0) OR (id != club_id)")
  }

  # po ulozeni kontroluju, zda jde o tym nebo klub; pokud klub, upravim ho tak,
  # aby odpovidal podminkam. Musim to delat az after_save, protoze u nove
  # vytvarenych klubu potrebuju znat id
  after_save do
    logger.info "AFTER SAVE CALLED"
    logger.info "self.club_id: " + self.club_id.to_s
    logger.info "self.level " + self.level.to_s

    changed = false

    # pokud nemam nastaven klub, jedna se o oddil
    if self.club_id == nil || self.club_id == ""
      self.club_id = self.id
      changed = true
    end
    # kazdy oddil ma level 0
    if self.club_id == self.id && self.level != 0
      self.level = 0
      changed = true
    end

    if changed
      self.save
    end
  end
end
