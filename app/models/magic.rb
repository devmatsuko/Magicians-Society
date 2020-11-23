class Magic < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :magic_favorites
  has_many :magic_comments

  # バリデーション
  validates :title, :video, :body, :presence => true

  # モデルとアップローダの紐付け
  mount_uploader :video, VideoUploader
  
  # 指定のユーザーがいいねをしているかを判定するメソッド
  def favorited_by?(user)
    magic_favorites.where(user_id: user.id).exists?
  end

end
