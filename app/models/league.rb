class League < ActiveRecord::Base
  has_many :league_teams, dependent: :destroy
  has_many :games, dependent: :destroy

  attr_accessible :group, :level, :name, :short_name, :shortcut, :cfbu_profile_data

  def cfbu_profile_link
    return cfbu_profile_data ?
      "http://www.cfbu.cz/redakcni_system/index.php?tabulka=1&soutez=" + cfbu_profile_data :
      nil;
  end

  def self.get_data_from_cfbu_profile_link(link)
    if link == nil
      return nil
    else
      tmp = link.split("soutez=")
      return tmp.size > 1 ? tmp[1].split("&")[0] : link
    end
  end

  before_validation do |record|
    # prazdne retezce nastavim na null
    record.name = record.name != "" ? record.name : nil
    record.short_name = record.short_name != "" ? record.short_name : nil
    record.cfbu_profile_data = record.cfbu_profile_data != "" ? record.cfbu_profile_data : nil

    # zparsuju profile data, kdybych nahodou tam flaknul celej link
    record.cfbu_profile_data = League.get_data_from_cfbu_profile_link(record.cfbu_profile_data)
  end
end
