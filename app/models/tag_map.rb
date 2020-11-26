class TagMap < ApplicationRecord

  # アソシエーション
  belongs_to :magic
  belongs_to :tag

  # バリデーション
  validates :magic_id, presence: true
  validates :tag_id, presence: true

end
