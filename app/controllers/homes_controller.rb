class HomesController < ApplicationController

  def top
    # 退会していないユーザーのマジック投稿をランダムに4投稿取得
    @magics = Magic.eager_load(:user).where(users: {is_deleted: false}).order("RANDOM()").limit(4)
    # 退会していない全ユーザーの商品をランダムに4投稿取得
    @products = Product.eager_load(:user).where(users: {is_deleted: false}).order("RANDOM()").limit(4)

  end

  def about
  end

  # 検索機能
  def search
    # 検索ワード
    @content = params["content"]
    # 投稿検索結果
    @magics = partical_magic(@content).page(params[:page]).per(8)
    # 商品検索結果
    @products = partical_product(@content).page(params[:page]).per(10)
  end

  private
  # 投稿検索
  def partical_magic(content)
    Magic.eager_load(:user).where(users: {is_deleted: false}).where("title LIKE ?", "%#{content}%")

  end

  # 商品検索
  def partical_product(content)
    Product.eager_load(:user).where(users: {is_deleted: false}).where("name LIKE ?", "%#{content}%")
  end

end
