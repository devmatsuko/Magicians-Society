class MagicFavoritesController < ApplicationController
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!

  # いいねの追加
  def create
    @magic = Magic.find(params[:magic_id])
    favorite = @magic.magic_favorites.new(user_id: current_user.id)
    favorite.save
  end

  # いいねの削除
  def destroy
    @magic = Magic.find(params[:magic_id])
    favorite = @magic.magic_favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end
end
