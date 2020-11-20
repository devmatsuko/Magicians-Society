class SalesController < ApplicationController

	# ログインユーザーの販売履歴を新着順にの取得(ページャ機能で8投稿ずつ表示する)
  def index
    @orders = Order.eager_load(:product).where(products: { user_id: current_user.id }).order('orders.created_at DESC').page(params[:page]).per(8)

  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "注文ステータスを変更しました。"
      redirect_to sale_path(@order)
    else
      render :show
    end
  end

  private
  # ストロングパラメータ
  def order_params
    params.require(:order).permit(:order_status)
  end

end
