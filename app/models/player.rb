# To change this template, choose Tools | Templates
# and open the template in the editor.

class Player < ActiveRecord::Base
  attr_accessible :first_name, :second_name, :nick_name, :birthday, :note,
    :icon, :icon_cache, :cfbu_profile_data,
    :team, :team_id, :weight, :height, :stick_holding

  belongs_to :team

  mount_uploader :icon, PlayerIconUploader

  def get_name
    if (first_name == nil && second_name == nil)
      return nil;
    end

    if (first_name == nil)
      return second_name
    end

    if (second_name == nil)
      return first_name
    end

    return first_name + " " + second_name
  end

  def get_name_including_nick
    if (nick_name != nil)
      return nick_name
    end

    return get_name
  end

  def get_name_for_list
    if (nick_name)
      return get_name + " (" + nick_name + ")"
    end

    return get_name
  end

  def team_name
    return team != nil ? team.name : nil
  end

  def cfbu_profile_link
    return cfbu_profile_data ?
      "http://fis.cfbu.cz/index.php?pageid=2501&onlycontent=1&personal_id=" + cfbu_profile_data :
      nil;
  end

  def profile_image
    url = icon_url(:full)
    return url != nil && url != "" ?
      ActionController::Base.helpers.image_tag(url) :
      ActionController::Base.helpers.image_tag(ActionController::Base.helpers.asset_path(DEFAULT_IMAGES[:player_icon]))
  end

  def self.get_data_from_cfbu_profile_link(link)
    if link == nil
      return nil
    else
      tmp = link.split("personal_id=")
      return tmp.size > 1 ? tmp[1].split("&")[0] : link
    end
  end

  before_validation do |record|
    # prazdne retezce nastavim na null
    record.first_name = record.first_name != "" ? record.first_name : nil
    record.second_name = record.second_name != "" ? record.second_name : nil
    record.nick_name = record.nick_name != "" ? record.nick_name : nil
    record.note = record.note != "" ? record.note : nil
    record.cfbu_profile_data = record.cfbu_profile_data != "" ? record.cfbu_profile_data : nil

    # zparsuju profile data, kdybych nahodou tam flaknul celej link
    record.cfbu_profile_data = Player.get_data_from_cfbu_profile_link(record.cfbu_profile_data)
  end
  
  ##############################################################################
  
  scope :randomize, -> {
    order('random()')
  }
  
  scope :birthday, ->(date = Date.today) {
    where('(extract(day from birthday) = ?)AND(extract(month from birthday) = ?)',
      date.mday, date.mon)
  }
end
