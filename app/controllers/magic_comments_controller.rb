class MagicCommentsController < ApplicationController

  # ログイン中のユーザのみアクセス許可
  before_action :authenticate_user!

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

end
