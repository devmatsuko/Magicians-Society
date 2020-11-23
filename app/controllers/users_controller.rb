class UsersController < ApplicationController
  
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!, only: [:edit, :update, :withdrawal]

  def index
    # 退会していない全ユーザーの取得(ページャ機能で8ユーザーずつ表示する)
    @users = User.where(is_deleted: false).page(params[:page]).per(8)
  end

  def show
    # アクセスしたユーザー情報を取得
    @user = User.find(params[:id])
  end

  def edit
    # アクセスしたユーザー情報を取得
    @user = User.find(params[:id])
  end

  def update
    # アクセスしたユーザー情報を取得
    @user = User.find(params[:id])
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

end
