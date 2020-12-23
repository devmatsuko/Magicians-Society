class ProductsController < ApplicationController
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!, only: [:new, :edit, :create, :update]
  # 新規商品登録時の商品情報の取得
  before_action :new_product, only: [:create]
  # 商品情報が必要なメソッドは、先に指定IDの商品を取得していく。
  before_action :set_product, only: [:show, :edit, :update]
  # ジャンルの取得が必要なメソッドでは、先にジャンルを取得しておく
  before_action :set_genres, only: [:new, :edit, :index, :create, :update]
  # 他ユーザーのアクション制限
  before_action :ensure_current_user, {only: [:edit, :update]}
  # ゲストユーザーのアクションの制限
  before_action :check_guest, only: [:create, :update]
  # 投稿画像のセーフサーチ
  before_action :check_image, only: [:create, :update]

  def index
    # ジャンル検索の有無に関係なく退会していない全ユーザーのマジック商品を取得(ページャ機能で12投稿ずつ表示する)
    @all_products = Product.eager_load(:user).where(users: { is_deleted: false }).page(params[:page]).per(12)
    if params[:genre_id]
      # ジャンル検索の場合、検索ジャンルに当てはまる商品を取得(ページャ機能で12投稿ずつ表示する)
      @products = Product.eager_load(:genre).where(genre_id: params[:genre_id]).eager_load(:user).where(users: { is_deleted: false }).page(params[:page]).per(12)
      # 検索ジャンルの取得
      @genre = Genre.find(params[:genre_id])
    else
      # 退会していない全ユーザーのマジック商品を取得(ページャ機能で12投稿ずつ表示する)
      @products = Product.eager_load(:user).where(users: { is_deleted: false }).page(params[:page]).per(12)
    end
  end

  def new
    # 新規投稿用のインスタンス変数
    @product = Product.new
  end

  def show
    @product_comment = ProductComment.new
  end

  def edit; end

  def create

    # 新規商品情報の保存
    if @safe_flag && @product.save
      flash[:notice] = '商品を登録しました。'
      redirect_to product_path(@product)
    else
      # エラーが発生した場合
      render :new
    end
  end

  def update
    if @safe_flag && @product.update(product_params)
      flash[:notice] = '商品内容を変更しました。'
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

  def new_product
    # 新規商品情報の取得
    @product = Product.new(product_params)
    @product.user_id = current_user.id
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
  
  # 他ユーザーのアクション制限
  def ensure_current_user
    product = Product.find(params[:id])
    if product.user_id != current_user.id
      flash[:notice]="権限がありません"
      redirect_to products_path
    end
  end

  # ゲストユーザーのアクションを制限する
  def check_guest
    if current_user.email == 'guest@example.com'
      flash[:notice] = 'ゲストユーザーはデータの登録・更新・削除はできません。'
      redirect_to request.referer
    end
  end

  # 画像のセーフサーチ
  def check_image
    # セーフチェックフラグの初期値(不適切でない場合にtrueに変更する。)
    @safe_flag = false
    # 画像の更新があった場合
    if product_params[:image] != "{}" && product_params[:image].class == ActionDispatch::Http::UploadedFile
      image = File.open(product_params[:image].tempfile)
      # セーフサーチの実施・結果
      safe_results = Vision.get_image_data(image)
      # 画像が不適切だった場合
      if safe_results.value?("LIKELY") || safe_results.value?("VERY_LIKELY")
        @product.errors.add(:image, "が不適切な画像と判断されました。")
      else
        # 画像が適切である場合
        @safe_flag = true
      end
    else
      # 画像の更新がない場合
      @safe_flag = true
    end
  end

end
