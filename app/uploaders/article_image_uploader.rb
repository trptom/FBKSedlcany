# encoding: utf-8

class ArticleImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :resize_and_pad => [200, 150]
  version :small

  version :large do
    process :resize_and_pad => [400, 300]
  end

  def extension_white_list
    %w(jpg jpeg png gif bmp)
  end
end
