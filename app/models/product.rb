class Product < ApplicationRecord

  # 多重度の設定
  belongs_to :genre
  belongs_to :user
  has_many :orders
  has_many :product_favorites
  has_many :product_comments

  # 画像を設定できるようにする
  attachment :image, destroy: false

  # バリデーションチェック
  # 空白時にエラー
  validates :name, :explanation, :genre_id, :after_tax_price, :image, presence: true
  # 数値以外が入力された場合はエラー
  validates :after_tax_price, numericality: { only_integer: true }
  # is_saleの値がtrue,false以外の場合はエラー
  validates :is_sale, inclusion: [true, false]

end
