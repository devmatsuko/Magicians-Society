class MagicsController < ApplicationController

  # 投稿情報が必要なメソッドは、先に指定IDの商品を取得していく。
  before_action :set_magic, only: [:show, :edit, :update, :destroy]
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]


  def index
    # 退会していない全ユーザーのマジック投稿を取得(ページャ機能で8投稿ずつ表示する)
    @magics = Magic.eager_load(:user).where(users: {is_deleted: false}).page(params[:page]).per(8)
  end

  def new
    # 新規投稿用のインスタンス変数
    @magic = Magic.new
  end

  def show
    @magic_comment = MagicComment.new
  end

  def edit
  end

  def create
    # 投稿内容を取得
    @magic = Magic.new(magic_params)
    @magic.user_id = current_user.id
    if @magic.save
      flash[:notice] = "動画を投稿しました。"
      redirect_to magic_path(@magic)
    else
      # エラーが発生した場合
      render :new
    end
  end

  def update
    if @magic.update(magic_params)
      flash[:notice] = "投稿内容を変更しました。"
      redirect_to magic_path(@magic)
    else
      render :edit
    end
  end

  def destroy
    if @magic.destroy
      flash[:notice] = "動画を削除しました。"
      redirect_to magics_path
    else
      # エラーが発生した場合
      render :edit
    end
  end

  private
  # ストロングパラメータ
  def magic_params
    params.require(:magic).permit(:user_id, :title, :body, :video)
  end

  # 指定IDの投稿情報の取得
  def set_magic
    # IDに基づく投稿を取得
    @magic = Magic.find(params[:id])
  end
end