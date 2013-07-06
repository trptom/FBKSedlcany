# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'

  version :full

  version :medium do
    process :resize_to_fit => [600, 600]
  end

  version :small do
    process :resize_to_fit => [300,300]
  end

  version :tiny do
    process :resize_to_fit => [20,20]
  end

  def extension_white_list
    %w(jpg jpeg png gif bmp)
  end
end
