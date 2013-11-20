# encoding: utf-8

class ArticleImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :resize_to_fit => [200, 10000]

  def extension_white_list
    %w(jpg jpeg png gif bmp)
  end
end
