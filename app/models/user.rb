class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :magics, dependent: :destroy

  # 画像を設定できるようにする
  attachment :image, destroy: false

  # 退会済のユーザーのログインを拒否するメソッド
  def active_for_authentication?
   super && (self.is_deleted == false)
  end


end
