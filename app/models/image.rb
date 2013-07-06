class Image < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :user
  attr_accessible :description, :image, :logical_folder, :name, :user, :user_id, :image_cache

  def get_full_path
    return logical_folder == "" ? name : logical_folder + "/" + name
  end
end
