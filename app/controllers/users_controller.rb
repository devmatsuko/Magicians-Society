class UsersController < ApplicationController
  # ユーザー情報が必要なメソッドは、先に指定IDのユーザーを取得していく。
  before_action :set_user, only: [:show, :edit, :update, :withdrawal]
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!, only: [:edit, :update, :withdrawal, :withdrawal_show]
  # 他ユーザーのアクション制限
  before_action :ensure_current_user, {only: [:edit, :update, :withdrawal, :withdrawal_show]}
  # ゲストユーザーのアクションの制限
  before_action :check_guest, only: [:update, :withdrawal]
  

  def index
    # 退会していない全ユーザーの取得(ページャ機能で8ユーザーずつ表示する)
    @users = User.where(is_deleted: false).page(params[:page]).per(8)
  end

  def show
    if @user.is_deleted == true
      flash[:notice] = 'アクセスしたユーザーは退会済みです。'
      # 退会していない全ユーザーの取得(ページャ機能で8ユーザーずつ表示する)
      @users = User.where(is_deleted: false).page(params[:page]).per(8)
      render 'index'
    end

    # ユーザーのマジック投稿、出品商品、フォロー、フォロワー情報の取得
    @magics = @user.magics.page(params[:page]).per(8)
    @products = @user.products.page(params[:page]).per(12)
    @following = @user.following.where(is_deleted: false).page(params[:page]).per(8)
    @followers = @user.followers.where(is_deleted: false).page(params[:page]).per(8)

    if user_signed_in?
      # チャットルームのエントリー用のパラメータ
      # 自分のuser_idを含んでいるエントリーを取得
      @currentUserEntry = Entry.where(user_id: current_user.id)
      # 現在参照しているユーザのuser_idを含んでいるエントリーを取得
      @userEntry = Entry.where(user_id: @user.id)

      if @user.id != current_user.id
        # 自分と相手のエントリーを比較し、同じルームIDのルームを取得
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end

        # ルームがすでに存在していた場合は何もしない
        if @isRoom

        # ルームが存在していない場合は新たにルームとエントリーを作成する
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'ユーザー情報を更新しました。'
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  # 退会画面
  def withdrawal_show; end

  # 退会機能
  def withdrawal
    # アクセスしたユーザー情報を取得
    @user = User.find(params[:id])
    # 退会フラグをtrueに変更する。
    @user.update(is_deleted: true)
    # ユーザーのセッションを破棄する
    reset_session
    # 退会後メッセージ
    flash[:notice] = 'ありがとうございました。またのご利用を心よりお待ちしております。'
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

  # ゲストユーザーのアクションを制限する
  def check_guest
    if current_user.email == 'guest@example.com'
      flash[:notice] = 'ゲストユーザーはデータの登録・更新・削除はできません。'
      redirect_to request.referer
    end
  end

  # 他ユーザーのアクション制限
  def ensure_current_user
    if current_user.id != params[:id].to_i
      flash[:notice]="権限がありません。"
      redirect_to  user_path(current_user)
    end
  end

end
