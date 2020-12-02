class ProductFavorite < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :product
end
