class HomesController < ApplicationController
    
  def top
    # 退会していないユーザーのマジック投稿をランダムに4投稿取得
    @magics = Magic.eager_load(:user).where(users: {is_deleted: false}).order("RANDOM()").limit(4)
    # 退会していない全ユーザーの商品をランダムに4投稿取得
    @products = Product.eager_load(:user).where(users: {is_deleted: false}).order("RANDOM()").limit(4)
    
  end
  
  def about
  end
    
end
  