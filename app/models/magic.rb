class Magic < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :magic_favorites
  has_many :magic_comments

  # バリデーション
  validates :title, :video, :body, :presence => true

  # モデルとアップローダの紐付け
  mount_uploader :video, VideoUploader

end
