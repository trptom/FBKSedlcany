# To change this template, choose Tools | Templates
# and open the template in the editor.

class Player < ActiveRecord::Base
  attr_accessible :first_name, :second_name, :nick_name, :birthday, :note, :icon, :team, :cfbu_profile_data

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

  def cfbu_profile_link
    return "http://fis.cfbu.cz/index.php?pageid=2501&onlycontent=1&personal_id=" + cfbu_profile_data
  end

  def parse_data_from_cfbu_profile_link(link)
    tmp = link.split("&personal_id=")
    update_attribute(:cfbu_profile_data, tmp.size >= 1 ? tmp[1].split("&")[0] : link)
  end
end
