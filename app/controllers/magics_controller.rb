class MagicsController < ApplicationController
  # 投稿情報が必要なメソッドは、先に指定IDの投稿を取得していく。
  before_action :set_magic, only: [:show, :edit, :update, :destroy]
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  # 他ユーザーのアクション制限
  before_action :ensure_current_user, {only: [:edit, :update, :destroy]}
  # ゲストユーザーのアクションの制限
  before_action :check_guest, only: [:create, :update, :destroy]

  def index
    # 退会していない全ユーザーのマジック投稿を取得(ページャ機能で8投稿ずつ表示する)
    @magics = Magic.eager_load(:user).where(users: { is_deleted: false }).page(params[:page]).per(8)
  end

  def new
    # 新規投稿用のインスタンス変数
    @magic = Magic.new
    # タグの初期値をnilにする
    @tag_list = nil
  end

  def show
    # コメントフォーム用のインスタンス
    @magic_comment = MagicComment.new
    # 投稿に紐づいているタグの取得
    @tag_list = @magic.tags
  end

  def edit
    # タグをスペース区切りで合体させる
    @tag_list = @magic.tags.pluck(:tag).join(' ')
  end

  def create
    # 投稿内容を取得
    @magic = Magic.new(magic_params)
    # 入力されたタグ名の取得
    tag_list = params[:magic][:tag].split(nil)
    @magic.user_id = current_user.id
    if @magic.save
      # タグの保存
      @magic.save_tag(tag_list)
      flash[:notice] = '動画を投稿しました。'
      redirect_to magic_path(@magic)
    else
      # エラーが発生した場合
      render :new
    end
  end

  def update
    # 入力されたタグ名の取得
    tag_list = params[:magic][:tag].split(nil)
    if @magic.update(magic_params)
      # タグの保存
      @magic.save_tag(tag_list)
      flash[:notice] = '投稿内容を変更しました。'
      redirect_to magic_path(@magic)
    else
      render :edit
    end
  end

  def destroy
    if @magic.destroy
      flash[:notice] = '動画を削除しました。'
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
  
  # 他ユーザーのアクション制限
  def ensure_current_user
    magic = Magic.find(params[:id])
    if magic.user_id != current_user.id
      flash[:alert]="権限がありません。"
      redirect_to magics_path
    end
  end

  # ゲストユーザーのアクションを制限する
  def check_guest
    if current_user.email == 'guest@example.com'
      flash[:notice] = 'ゲストユーザーはデータの登録・更新・削除はできません。'
      redirect_to request.referer
    end
  end
end
