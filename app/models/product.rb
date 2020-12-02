class Product < ApplicationRecord
  # アソシエーション
  belongs_to :genre
  belongs_to :user
  has_many :orders
  has_many :product_favorites
  has_many :product_comments

  # 画像を設定できるようにする
  attachment :image, destroy: false

  # バリデーションチェック
  validates :name, :explanation, :genre, :product_status, :price, :is_sale, :shipping_method, :shipping_date, :postage_status, :image, presence: true
  validates :price, numericality: { only_integer: true }
  validates :is_sale, inclusion: [true, false]
  validates :name, length: { maximum: 20 }
  validates :explanation, length: { maximum: 200 }

  # ENUMの設定
  # 商品の状態
  enum product_status: {
    "新品、未使用": 0,
    "未使用に近い": 1,
    "目立った傷や汚れなし": 2,
    "やや傷や汚れあり": 3,
    "傷や汚れあり": 4,
    "全体的に状態が悪い": 5
  }
  # 配送方法
  enum shipping_method: { "未定": 0, "クロネコヤマト": 1, "レターパック": 2 }
  # 発送までの日数
  enum shipping_date: { "1〜2日で発送": 0, "2〜3日で発送": 2, "4〜7日で発送": 2 }
  # 配送方法
  enum postage_status: { "送料込み(出品者負担)": 0, "着払い(購入者負担)": 1 }

  # 指定のユーザーがいいねをしているかを判定するメソッド
  def favorited_by?(user)
    product_favorites.where(user_id: user.id).exists?
  end
end
