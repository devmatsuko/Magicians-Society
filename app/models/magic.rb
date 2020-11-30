class Magic < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :magic_favorites, dependent: :destroy
  has_many :magic_comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  # バリデーション
  validates :title, :video, :body, :presence => true
  validates :title, length: { maximum: 20 }
	validates :body, length: { maximum: 200 }

  # モデルとアップローダの紐付け
  mount_uploader :video, VideoUploader

  # 指定のユーザーがいいねをしているかを判定するメソッド
  def favorited_by?(user)
    magic_favorites.where(user_id: user.id).exists?
  end

  # 投稿に紐づくタグの保存
  def save_tag(sent_tags)
    # 指定した投稿に紐づくタグが既に存在する場合にタグを取得
    current_tags = self.tags.pluck(:tag) unless self.tags.nil?
    # 既に存在するタグのみを取得
    old_tags = current_tags - sent_tags
    # 新規のタグのみを取得
    new_tags = sent_tags - current_tags

    # 既に存在するタグは保存対象から削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag: old)
    end

    # 新規のタグのみを保存する
    new_tags.each do |new|
      new_magic_tag = Tag.find_or_create_by(tag: new)
      self.tags << new_magic_tag
    end
  end

end
