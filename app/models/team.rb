class Team < ActiveRecord::Base
  mount_uploader :logo, ClubLogoUploader

  belongs_to :club, dependent: :destroy
  has_many :players

  attr_accessible :level, :logo, :name, :short_name, :shortcut, :club

  def self.get_name
    if self.name != nil
      return self.name
    end
    return self.club.name
  end

  def self.get_short_name
    if self.short_name != nil
      return self.short_name
    end
    return self.club.short_name
  end

  def self.get_shortcut
    if self.shortcut != nil
      return self.shortcut
    end
    return self.club.shortcut
  end

  def self.get_logo(type)
    if self.image
      return self.logo_url(type)
    end
    return self.club.logo_url(type)
  end

  def self.get_options(atts)
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
end
