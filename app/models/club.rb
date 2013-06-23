class Club < ActiveRecord::Base
  mount_uploader :logo, ClubLogoUploader

  has_many :teams

  attr_accessible :logo, :logo_cache, :name, :short_name, :shortcut

  def get_logo_image
    return ActionController::Base.helpers.image_tag(logo_url(:full))
  end

  def get_small_logo_image
    return ActionController::Base.helpers.image_tag(logo_url(:small))
  end
end
