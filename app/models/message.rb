class Message < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :room

  # バリデーション
  validates :content, presence: true
end
