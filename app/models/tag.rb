class Tag < ApplicationRecord
  # アソシエーション
  has_many :tag_maps, dependent: :destroy
  has_many :magics, through: :tag_maps
end
