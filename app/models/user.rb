class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :magics, dependent: :destroy
  # フォローする側のリレーションシップ
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # N：Nのリレーションシップにはthroughを使う。user.following = user.followed.idとなるようにsourceを設定
  has_many :following, through: :active_relationships, source: :followed
  # フォロワーのリレーションシップ
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id
  # N：Nのリレーションシップにはthroughを使う。user.followers = user.follower.idとなるようにsourceを設定
  has_many :followers, through: :passive_relationships, source: :follower

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



end
