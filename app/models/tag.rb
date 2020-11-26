class Tag < ApplicationRecord
  
  # アソシエーション
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :magics, through: :tag_maps
  
end
