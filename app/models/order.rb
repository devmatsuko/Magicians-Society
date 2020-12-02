class Order < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :product

  # バリデーション
  validates :pay_method, :postcode, :address, :name, presence: true
  validates :postcode, length: { is: 7 }, format: { with: /\A[0-9]+\z/ }

  # ENUMの設定
  enum pay_method: { "クレジットカード": 0, "銀行振込": 1 }
  enum order_status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }
end
