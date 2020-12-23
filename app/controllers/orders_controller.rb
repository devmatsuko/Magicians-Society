class OrdersController < ApplicationController
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!
  # 他ユーザーのアクション制限
  before_action :ensure_current_user, {only: [:show]}

  def new
    # 注文しているユーザーを取得
    @user = current_user
    # 注文した商品を取得
    @product = Product.find(params[:product_id])
    # 商品が売り切れの場合
    unless @product.is_sale
      flash[:alert] = 'この商品は売り切れのため、注文できません。'
      redirect_to product_path(@product)
    end
    # 新規注文用のインスタンス変数
    @order = Order.new(user_id: @user.id)
  end

  # ログインユーザーの注文履歴を新着順にの取得(ページャ機能で8投稿ずつ表示する)
  def index
    @orders = current_user.orders.order('created_at DESC').page(params[:page]).per(8)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    # 注文情報の取得
    @order = Order.new(order_params)
    # 注文しているユーザーを取得
    @user = current_user
    # shipping_addressが0の場合はユーザー情報から配送先情報を取得(1の場合はフォームの情報を取得)
    if params[:order][:shipping_address] == '0'
      @order.postcode = @user.postcode
      @order.address = @user.address
      @order.name = @user.full_name
    end

    if @order.save
      redirect_to thanks_orders_path
    else
      # 注文した商品を取得
      @product = @order.product
      render :new
    end
  end

  def thanks; end

  private

  # ストロングパラメータ
  def order_params
    params.require(:order).permit(
      :user_id,
      :product_id,
      :pay_method,
      :order_status,
      :total_price,
      :postage,
      :postcode,
      :address,
      :name
    )
  end

  # 他ユーザーのアクション制限
  def ensure_current_user
    order = Order.find(params[:id])
    if order.user_id != current_user.id
      flash[:alert]="権限がありません。"
      redirect_to orders_path
    end
  end

end
