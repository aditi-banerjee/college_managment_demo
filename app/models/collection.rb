class Collection < ApplicationRecord
  mount_uploader :image, CollectionImageUploader
end
