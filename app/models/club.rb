class Club < ActiveRecord::Base
  mount_uploader :logo, ClubLogoUploader

  has_many :teams, dependent: :destroy

  attr_accessible :logo, :logo_cache, :name, :short_name, :shortcut

  def get_club
    return teams.where(:level => 0).first
  end

  def get_teams
    return teams.where("level > 0").all
  end

  def get_logo_image
    return ActionController::Base.helpers.image_tag(logo_url(:full))
  end

  def get_small_logo_image
    return ActionController::Base.helpers.image_tag(logo_url(:small))
  end

  def create_default_team
    return Team.new(
      :club_id => id,
      :level => 0
    )
  end

  def self.get_options(atts)
    if (atts[:where])
      res = Club.where(atts[:where])
    else
      res = Club;
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
end
