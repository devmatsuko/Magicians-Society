class MagicCommentsController < ApplicationController
  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!
  # 他ユーザーのアクション制限
  before_action :ensure_current_user, {only: [:destroy]}

  def create
    @magic = Magic.find(params[:magic_id])
    @magic_comment = MagicComment.new(magic_comment_params)
    @magic_comment.magic_id = @magic.id
    @magic_comment.user_id = current_user.id
    if @magic_comment.save
    else
      render 'magics/show'
    end
  end

  def destroy
    @magic = Magic.find(params[:magic_id])
    MagicComment.find_by(id: params[:id], magic_id: params[:magic_id]).destroy
  end

  private

  def magic_comment_params
    params.require(:magic_comment).permit(:comment)
  end

  # 他ユーザーのアクション制限
  def ensure_current_user
    magic_comment = MagicComment.find(params[:id])
    if magic_comment.user_id != current_user.id
      flash[:alert]="権限がありません。"
      redirect_to magics_path
    end
  end
end
