# encoding: utf-8

class ClubLogoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'

  version :full do
    process :resize_to_fit => [200, 200]
  end

  version :small do
    process :resize_to_fit => [50,50]
  end
end
