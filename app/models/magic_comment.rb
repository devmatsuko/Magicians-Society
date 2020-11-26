class MagicComment < ApplicationRecord
  
  # アソシエーション
	belongs_to :user
	belongs_to :magic

	# バリデーション
	validates :comment, presence: true
	
  
end
