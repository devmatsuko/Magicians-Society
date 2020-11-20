class ProductFavoritesController < ApplicationController

	# いいねの追加
	def create
    @product = Product.find(params[:product_id])
    favorite = @product.product_favorites.new(user_id: current_user.id)
    favorite.save
	end

	# いいねの削除
  def destroy
    @product = Product.find(params[:product_id])
    favorite = @product.product_favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end

end
