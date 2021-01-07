Rails.application.routes.draw do

  # 管理者
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # ルートパスをTOPページに設定
  root 'homes#top'
  # サイト紹介ページ
  get '/about' => 'homes#about', as: 'about'
  # 検索機能
  get '/search' => 'homes#search', as: 'search'
  # タグ検索機能
  get '/tag_search/:id' => 'tags#search', as: 'tag_search'
  # ランキング画面
  get '/ranking' => 'homes#ranking', as: 'ranking'


  # ログイン関連(利用しない機能のルーティングは削除する)
  devise_for :users, skip: :all
  devise_scope :user do
    # サインアップ
    get 'users/sign_up' =>'users/registrations#new', as: :new_user_registration
    post 'users'=>'users/registrations#create', as: :user_registration
    # ログイン、ログアウト
    get 'users/sign_in'=>'users/sessions#new', as: :new_user_session
    post 'users/sign_in'=>'users/sessions#create', as: :user_session
    delete 'users/sign_out' =>'users/sessions#destroy', as: :destroy_user_session
    # ゲストログイン
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  # ユーザー関連
  resources :users, only: [:index,:show,:edit,:update] do
    # member内書くことでURLにidが加わる。ex)/users/:id/following
    member do
      get :following, :followers
      get 'withdrawal' => 'users#withdrawal_show'
      patch :withdrawal
    end

    # フォロー・フォロワー関連
    resource :relationships, only: [:create, :destroy]
  end

  # マジック投稿関連
  resources :magics do
    # 投稿いいね関連
    resource :magic_favorites, only: [:create, :destroy]
    # 投稿コメント関連
    resources :magic_comments, only: [:create, :destroy]
  end

  # 商品関連
  resources :products, except: [:destroy] do
    # 商品いいね関連
    resource :product_favorites, only: [:create, :destroy]
    # 商品コメント関連
    resources :product_comments, only: [:create, :destroy]
  end

  # 注文関連
  resources :orders, only: [:new, :create, :index, :show] do
    # サンクスページ
    collection do
      get :thanks
    end
  end

  # 販売関連
  resources :sales, only: [:update, :index, :show]

  # チャットルーム関連
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]

end
