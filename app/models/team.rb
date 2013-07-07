class Team < ActiveRecord::Base
  mount_uploader :logo, ClubLogoUploader

  belongs_to :club
  has_many :players

  attr_accessible :level, :logo, :logo_cache, :name, :short_name, :shortcut, :club, :club_id

  before_validation do |record|
    record.logo = record.logo == nil || record.logo = "" ?
      record.club.logo : record.logo
    record.name = record.name == nil || record.name = "" ?
      record.club.name : record.name
    record.short_name = record.short_name == nil || record.short_name = "" ?
      record.club.short_name : record.short_name
    record.shortcut = record.shortcut == nil || record.shortcut = "" ?
      record.club.shortcut : record.shortcut
  end

  def logo_image(type = :full)
    url = logo_url(type)
    return url != nil && url != "" ? ActionController::Base.helpers.image_tag(url) : nil
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
