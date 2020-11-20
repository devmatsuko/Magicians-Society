class ProductCommentsController < ApplicationController

	def create
    @product = Product.find(params[:product_id])
		@product_comment = ProductComment.new(product_comment_params)
		@product_comment.product_id = @product.id
		@product_comment.user_id = current_user.id
    if @product_comment.save
    else
      render 'products/show'
    end
	end

  def destroy
    @product = Product.find(params[:product_id])
    ProductComment.find_by(id: params[:id], product_id: params[:product_id]).destroy
  end

  private
  def product_comment_params
    params.require(:product_comment).permit(:comment)
  end

end
