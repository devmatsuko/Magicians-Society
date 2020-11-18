class ProductsController < ApplicationController

	# 商品情報が必要なメソッドは、先に指定IDの商品を取得していく。
  before_action :set_product, only: [:show, :edit, :update]
  # ジャンルの取得が必要なメソッドでは、先にジャンルを取得しておく
  before_action :set_genres, only: [:new, :edit, :index, :create, :update]

	def index
	  # ジャンル検索の有無に関係なく退会していない全ユーザーのマジック商品を取得(ページャ機能で12投稿ずつ表示する)
    @all_products = Product.eager_load(:user).where(users: {is_deleted: false}).page(params[:page]).per(12)
    if params[:genre_id]
      # ジャンル検索の場合、検索ジャンルに当てはまる商品を取得(ページャ機能で12投稿ずつ表示する)
      @products = Product.eager_load(:genre).where(genre_id: params[:genre_id]).eager_load(:user).where(users: {is_deleted: false}).page(params[:page]).per(12)
      # 検索ジャンルの取得
      @genre = Genre.find(params[:genre_id])
    else
      # 退会していない全ユーザーのマジック商品を取得(ページャ機能で12投稿ずつ表示する)
      @products = Product.eager_load(:user).where(users: {is_deleted: false}).page(params[:page]).per(12)
    end
	end

  def new
    # 新規投稿用のインスタンス変数
    @product = Product.new
  end

  def show
  end

  def edit
  end

  def create
    # 新規商品情報の取得
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    # 新規商品情報の保存
    if @product.save
      flash[:notice] = "商品を登録しました。"
      redirect_to product_path(@product)
    else
      # エラーが発生した場合
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "商品内容を変更しました。"
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  private
  # ストロングパラメータ
  def product_params
    params.require(:product).permit(
      :user_id, 
      :genre_id, 
      :name, 
      :explanation, 
      :product_status, 
      :price, 
      :is_sale, 
      :image, 
      :shipping_method, 
      :shipping_date,
      :postage_status,
      :rate
    )
  end

  # 指定IDの商品情報の取得
  def set_product
    # IDに基づく商品を取得
    @product = Product.find(params[:id])
  end

  # ジャンルの取得
  def set_genres
    @genres = Genre.all
  end

end
