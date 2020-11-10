class Batch::CreateMvc
  
  # モデルの一括作成
  def self.create_model
    
    system 'rails g model Magic'
    system 'rails g model MagicFavorite'
    system 'rails g model MagicComment'
    system 'rails g model TagMap'
    system 'rails g model Tag'
    system 'rails g model Relationship'
    system 'rails g model Product'
    system 'rails g model ProductFavorite'
    system 'rails g model ProductComment'
    system 'rails g model Genre'
    system 'rails g model Order'
    
  end
  
  # コントローラの一括作成
  def self.create_controller
    
    system 'rails g controller Magics'
    system 'rails g controller MagicFavorites'
    system 'rails g controller MagicComments'
    system 'rails g controller TagMaps'
    system 'rails g controller Tags'
    system 'rails g controller Relationships'
    system 'rails g controller Products'
    system 'rails g controller ProductFavorites'
    system 'rails g controller ProductComments'
    system 'rails g controller Genres'
    system 'rails g controller Orders'
    system 'rails g controller Sales'
    system 'rails g controller Homes'
    system 'rails g controller Users'
    
  end
  
  # ビューの一括作成
  def self.create_view
    
    # TOP画面、About画面
    system 'touch app/views/homes/top.html.erb'
    system 'touch app/views/homes/about.html.erb'
    # ユーザー関連の画面
    system 'rails g devise:views users'
    system 'touch app/views/users/index.html.erb'
    system 'touch app/views/users/show.html.erb'
    system 'touch app/views/users/edit.html.erb'
    system 'touch app/views/users/withdrawal_show.html.erb'
    # マジック投稿関連の画面
    system 'touch app/views/magics/show.html.erb'
    system 'touch app/views/magics/new.html.erb'
    system 'touch app/views/magics/edit.html.erb'
    system 'touch app/views/magics/index.html.erb'
    # 商品関連の画面
    system 'touch app/views/products/show.html.erb'
    system 'touch app/views/products/new.html.erb'
    system 'touch app/views/products/edit.html.erb'
    system 'touch app/views/products/index.html.erb'
    # 注文関連の画面
    system 'touch app/views/orders/new.html.erb'
    system 'touch app/views/orders/confirm.html.erb'
    system 'touch app/views/orders/thanks.html.erb'
    system 'touch app/views/orders/index.html.erb'
    system 'touch app/views/orders/show.html.erb'
    # 出品関連の画面
    system 'touch app/views/sales/index.html.erb'
    system 'touch app/views/sales/show.html.erb'
    system 'touch app/views/sales/edit.html.erb'
    
  end
  
end