class MagicFavorite < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :magic
end
