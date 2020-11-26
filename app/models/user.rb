class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :magics, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  # フォローする側のリレーションシップ
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # N：Nのリレーションシップにはthroughを使う。user.following = user.followed.idとなるようにsourceを設定
  has_many :following, through: :active_relationships, source: :followed
  # フォロワーのリレーションシップ
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id
  # N：Nのリレーションシップにはthroughを使う。user.followers = user.follower.idとなるようにsourceを設定
  has_many :followers, through: :passive_relationships, source: :follower
  # 商品のいいね
  has_many :product_favorites
  # 商品のコメント
  has_many :product_comments
  # 投稿のいいね
  has_many :magic_favorites
  # 投稿のコメント
  has_many :magic_comments
  # チャットルームのアソシエーション
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # バリデーション
	validates :display_name, :description, :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postcode, :address, :phone_number, presence: true
	validates :postcode, length: { is: 7 }, format: { with: /\A[0-9]+\z/ }
	validates :phone_number, format: {with: /\A[0-9]+\z/}
	validates :display_name, length: { maximum: 20 }
	validates :description, length: { maximum: 200 }

  # 画像を設定できるようにする
  attachment :image, destroy: false

  # 退会済のユーザーのログインを拒否するメソッド
  def active_for_authentication?
   super && (self.is_deleted == false)
  end

  # 他ユーザーをフォローしているか判定するメソッド
  def following?(other_user)
    following.include?(other_user)
  end

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # ユーザーの姓名を結合する
  def full_name
    self.last_name + self.first_name
  end

  # ユーザーのカナ姓カナ名を結合する
  def full_name_kana
    self.last_name_kana + self.first_name_kana
  end

  # ゲストユーザーを作成する機能
  def self.guest
    find_or_create_by!(
      email: 'guest@example.com',
      display_name: 'ゲストマジシャン(閲覧用)',
      description: 'よろしくお願いします！',
      last_name: "ゲスト",
      first_name: "マジシャン",
      last_name_kana: "ゲスト",
      first_name_kana: "マジシャン",
      postcode: "1234567",
      address: "東京都ゲスト区ゲスト1-11-11",
      phone_number: "00000000000",
      is_deleted: false
    ) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end





end
