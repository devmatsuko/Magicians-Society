class Genre < ApplicationRecord

	# 多重度の設定
  has_many :products

end
