# encoding: utf-8

class ArticleImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :resize_to_fit => [200, nil]
  version :small

  version :large do
    process :resize_to_fit => [400, nil]
  end

  def extension_white_list
    %w(jpg jpeg png gif bmp)
  end
end
