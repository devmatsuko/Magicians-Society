class ProductComment < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :product

  # バリデーション
  validates :comment, presence: true
end
