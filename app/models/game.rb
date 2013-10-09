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
      :start, :season, :round, :score, :cfbu_profile_data

  def cfbu_profile_link
    return cfbu_profile_data ?
      "http://fis.cfbu.cz/index.php?pageid=2519&onlycontent=1&record_id=" + cfbu_profile_data :
      nil;
  end

  def self.get_data_from_cfbu_profile_link(link)
    if link == nil
      return nil
    else
      tmp = link.split("record_id=")
      return tmp.size > 1 ? tmp[1].split("&")[0] : link
    end
  end

  before_validation do |record|
    # prazdne retezce nastavim na null
    record.cfbu_profile_data = record.cfbu_profile_data != "" ? record.cfbu_profile_data : nil

    # zparsuju profile data, kdybych nahodou tam flaknul celej link
    record.cfbu_profile_data = Game.get_data_from_cfbu_profile_link(record.cfbu_profile_data)
  end
end
