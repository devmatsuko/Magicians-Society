class SalesController < ApplicationController
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!, only: [:index, :show, :update]
  # 他ユーザーのアクション制限
  before_action :ensure_current_user, {only: [:show,:update]}

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
      flash[:notice] = '注文ステータスを変更しました。'
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

  # 他ユーザーのアクション制限
  def ensure_current_user
    order = Order.find(params[:id])
    if order.user_id != current_user.id
      flash[:alert]="権限がありません。"
      redirect_to sales_path
    end
  end
end
