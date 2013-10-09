class Game < ActiveRecord::Base
  belongs_to :home_team, :class_name => "Team"
  belongs_to :away_team, :class_name => "Team"
  belongs_to :organizer, :class_name => "Team"

  belongs_to :creator, :class_name => "User"
  belongs_to :editor, :class_name => "User"

  belongs_to :league
  belongs_to :hall

  serialize :score

  attr_accessible :home_team_id, :away_team_id, :organizer_id, :home_team, :away_team, :organizer,
      :creator_id, :editor_id, :creator, :editor,
      :league_id, :hall_id, :league, :hall,
      :start, :season, :round, :score, :cfbu_profile_data

  def result_str(atts = nil)
    atts = atts ? atts : {}
    atts[:periods] = atts[:periods] ? atts[:periods] : false

    ret = ""
    ret += score && score[:total] && score[:total][:home] && score[:total][:away] != "" ? score[:total][:home].to_s : "-"
    ret += ":"
    ret += score && score[:total] && score[:total][:away] && score[:total][:away] != "" ? score[:total][:away].to_s : "-"
    
    if (score && score[:note])
      ret += score[:note]
    end

    if (atts[:periods])
      ret += " ("
      for a in 0..2
        ret += score && score[:periods] && score[:periods][:home] && score[:periods][:home][a] && score[:periods][:home][a] != "" ? score[:periods][:home][a].to_s : "-"
        ret += ":"
        ret += score && score[:periods] && score[:periods][:away] && score[:periods][:away][a] && score[:periods][:away][a] != "" ? score[:periods][:away][a].to_s : "-"
        if a < 2
          ret += ","
        end
      end
      ret += ")"
    end

    return ret
  end

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
