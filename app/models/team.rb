class Team < ActiveRecord::Base
  attr_accessible :level, :logo, :name, :short_name, :shortcut, :club

  belongs_to :club
  has_many :players

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

  def self.get_logo_url(type)
    if self.image
      return self.logo_url(type)
    end
    return self.club.logo_url(type)
  end
end
