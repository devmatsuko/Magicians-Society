class Magic < ApplicationRecord

  # アソシエーション
  belongs_to :user
  
  # バリデーション
  validates :title, :video, :body, :presence => true
  
  # モデルとアップローダの紐付け
  mount_uploader :video, VideoUploader

end
