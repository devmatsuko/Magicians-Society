class Entry < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :room
end
