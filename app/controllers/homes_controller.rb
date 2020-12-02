class HomesController < ApplicationController
  def top
    # 退会していないユーザーのマジック投稿をランダムに4投稿取得
    @magics = Magic.eager_load(:user).where(users: { is_deleted: false }).sample(4)
    # 退会していない全ユーザーの商品をランダムに4投稿取得
    @products = Product.eager_load(:user).where(users: { is_deleted: false }).sample(4)
  end

  def about; end

  def ranking
    # 退会していないユーザーのマジック投稿をいいね順に10投稿取得
    valid_magics = Magic.eager_load(:user).where(users: { is_deleted: false })
    @magics = valid_magics.find(MagicFavorite.group(:magic_id).limit(10).order('count(magic_id) desc').pluck(:magic_id))

    # 退会していないユーザーの商品をいいね順に10商品取得
    valid_products = Product.eager_load(:user).where(users: { is_deleted: false })
    @products = valid_products.find(ProductFavorite.group(:product_id).limit(10).order('count(product_id) desc').pluck(:product_id))
  end

  # 検索機能
  def search
    # 検索ワード
    @content = params['content']
    # 投稿検索結果
    @magics = partical_magic(@content).page(params[:page]).per(8)
    # 商品検索結果
    @products = partical_product(@content).page(params[:page]).per(12)
    # ユーザー検索
    @users = partical_user(@content).page(params[:page]).per(8)
  end

  private

  # 投稿検索
  def partical_magic(content)
    Magic.eager_load(:user).where(users: { is_deleted: false }).where('title LIKE ?', "%#{content}%")
  end

  # 商品検索
  def partical_product(content)
    Product.eager_load(:user).where(users: { is_deleted: false }).where('name LIKE ?', "%#{content}%")
  end

  # ユーザー検索
  def partical_user(content)
    User.where(is_deleted: false).where('display_name LIKE ?', "%#{content}%")
  end
end
