class Team < ActiveRecord::Base
  mount_uploader :logo, TeamLogoUploader

  belongs_to :club, :class_name => 'Team'
  has_many :teams, :class_name => 'Team', :foreign_key => 'club_id'
  
  has_many :players
  has_many :player_stats, dependent: :destroy
  has_many :league_teams, dependent: :destroy

  has_many :home_games, :class_name => 'Game', :foreign_key => 'home_team_id'
  has_many :away_games, :class_name => 'Game', :foreign_key => 'away_team_id'

  has_many :organized_games, :class_name => 'Game', :foreign_key => 'organizer_id'

  attr_accessible :level, :logo, :logo_cache, :name, :short_name, :shortcut, :club, :club_id,
    :cfbu_profile_data

  def is_club
#    return true
    return level == 0 && id == club_id
  end

  def is_team
    return level > 0 || id != club_id
  end

  def logo_image(type = :full, atts = nil)
    atts = atts ? atts : {}
    atts[:alt] = atts[:alt] ? atts[:alt] : I18n.t("messages.base.logo");
    atts[:title] = atts[:title] ? atts[:title] : name;

    url = logo_url(type)
    return url != nil && url != "" ? ActionController::Base.helpers.image_tag(url, atts) : nil
  end

  def games(atts = nil)
    atts = atts ? atts : {}
    
    if is_team || !(atts[:all])
      return Game.where("(home_team_id = #{id})OR(away_team_id = #{id})").order("start DESC")
    else
      list = [id]
      for team in teams
        list << team.id
      end
      return Game.where("(home_team_id IN (?))OR(away_team_id IN (?))", list, list).order("start DESC")
    end
#    (home_games + away_games).order("start DESC")
  end

  def squad
    if is_team
      return players
    else
      list = [id]
      for team in teams
        list << team.id
      end
      return Player.where("team_id IN (?)", list)
    end
  end

  def squad_viewable
    for item in TEAMS_WITH_VIEWABLE_SQUAD
      if (item.kind_of? Regexp)
        if item.match(name) || item.match(short_name) || item.match(shortcut)
          return true
        end
      else
        if item == name || item == short_name || item == shortcut
          return true
        end
      end
    end
    return false
  end
  
  def games_viewable
    for item in TEAMS_WITH_VIEWABLE_GAMES
      if (item.kind_of? Regexp)
        if item.match(name) || item.match(short_name) || item.match(shortcut)
          return true
        end
      else
        if item == name || item == short_name || item == shortcut
          return true
        end
      end
    end
    return false
  end

  def cfbu_profile_link
    return cfbu_profile_data ?
      "http://fis.cfbu.cz/index.php?pageid=2521&onlycontent=1&team_id=" + cfbu_profile_data :
      nil;
  end

  ##############################################################################

  def self.get_options(atts = nil)
    atts = atts ? atts : {}

    if (atts[:where])
      res = Team.where(atts[:where])
    else
      res = Team;
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
  
  def self.get_options_with_type(atts = nil)
    atts = atts ? atts : {}

    if (atts[:where])
      res = Team.where(atts[:where])
    else
      res = Team;
    end

    if (atts[:order_by])
      res = res.order(atts[:order_by])
    end

    ary = Array.new
    if (atts[:empty])
      ary << [ I18n.t("messages.base.no_team"), "" ]
    end
    res.all.each do |item|
      ary << [item.name + " (" + (item.is_club ? I18n.t("messages.base.club") : I18n.t("messages.base.team")) + ")", item.id];
    end

    return ary;
  end

  def self.get_club_options(atts = nil)
    atts = atts ? atts : {}

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
      ary << [ I18n.t("messages.base.no_club"), "" ]
    end
    res.all.each do |item|
      ary << [item.name, item.id];
    end

    return ary;
  end

  def self.get_team_options(atts = nil)
    atts = atts ? atts : {}

    if (atts[:where])
      res = Team.teams.where(atts[:where])
    else
      res = Team.teams;
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

  def self.get_club_data_from_cfbu_profile_link(link)
    if link == nil
      return nil
    else
      tmp = link.split("club_id=")
      return tmp.size > 1 ? tmp[1].split("&")[0] : link
    end
  end
  
  def self.get_team_data_from_cfbu_profile_link(link)
    if link == nil
      return nil
    else
      tmp = link.split("team_id=")
      return tmp.size > 1 ? tmp[1].split("&")[0] : link
    end
  end
  
  def self.my_club
    my_clubs.first
  end

  ##############################################################################

  scope :clubs, -> {
    where("(level = 0) AND (id = club_id)")
  }

  scope :teams, -> {
    where("(level > 0) OR (id != club_id)")
  }
  
  scope :my_clubs, -> {
    clubs.order(:created_at).where(:name => TEAM_NAME)
  }

  before_validation do |record|
    # prazdne retezce nastavim na null
    record.name = record.name != "" ? record.name : nil
    record.short_name = record.short_name != "" ? record.short_name : nil
    record.shortcut = record.shortcut != "" ? record.shortcut : nil
    record.cfbu_profile_data = record.cfbu_profile_data != "" ? record.cfbu_profile_data : nil

    # zparsuju profile data, kdybych nahodou tam flaknul celej link
    record.cfbu_profile_data = record.is_club ?
        Team.get_club_data_from_cfbu_profile_link(record.cfbu_profile_data) :
        Team.get_team_data_from_cfbu_profile_link(record.cfbu_profile_data)
  end

  # po ulozeni kontroluju, zda jde o tym nebo klub; pokud klub, upravim ho tak,
  # aby odpovidal podminkam. Musim to delat az after_save, protoze u nove
  # vytvarenych klubu potrebuju znat id
  after_save do
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
