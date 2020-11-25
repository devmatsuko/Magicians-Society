class UsersController < ApplicationController

  # ユーザー情報が必要なメソッドは、先に指定IDのユーザーを取得していく。
  before_action :set_user, only: [:show, :edit, :update, :withdrawal]
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!, only: [:edit, :update, :withdrawal]

  def index
    # 退会していない全ユーザーの取得(ページャ機能で8ユーザーずつ表示する)
    @users = User.where(is_deleted: false).page(params[:page]).per(8)
  end

  def show
    if @user.is_deleted == true
      flash[:notice] = "アクセスしたユーザーは退会済みです。"
      # 退会していない全ユーザーの取得(ページャ機能で8ユーザーずつ表示する)
      @users = User.where(is_deleted: false).page(params[:page]).per(8)
      render "index"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました。"
       redirect_to user_path(@user.id)
    else
       render "edit"
    end
  end

  # 退会機能
  def withdrawal
    # アクセスしたユーザー情報を取得
    @user = User.find(params[:id])
    # 退会フラグをtrueに変更する。
    @user.update(is_deleted: true)
    # ユーザーのセッションを破棄する
    reset_session
    # 退会後メッセージ
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  # ストロングパラメータ
  private
  def user_params
    params.require(:user).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postcode,
      :email,
      :address,
      :phone_number,
      :image,
      :display_name,
      :description
      )
  end

  # 指定IDのユーザー情報の取得
  def set_user
    @user = User.find(params[:id])
  end

end
