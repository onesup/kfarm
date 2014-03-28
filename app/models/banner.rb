class Banner < ActiveRecord::Base
  mount_uploader :banner_image, BannerImageUploader
end
