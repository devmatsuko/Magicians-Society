class MagicsController < ApplicationController

  def index
    # 退会していない全ユーザーのマジック投稿を取得(ページャ機能で8投稿ずつ表示する)
    @magics = Magic.eager_load(:magic).where(users: {is_deleted: false}, user_id: params[:user_id]).page(params[:page]).per(8)
  end

  def new
    # 新規投稿用のインスタンス変数
    @magic = Magic.new
  end

 private
  # ストロングパラメータ
  def magic_params
    params.require(:magic).permit(:user_id, :image, :body)
  end

end
