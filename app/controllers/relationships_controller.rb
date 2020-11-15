class RelationshipsController < ApplicationController
  
  def create
    # フォローする対象のユーザの取得
    user = User.find(params[:user_id])
    # カレントユーザが対象ユーザをフォローするメソッドを呼び出す
    current_user.follow(user)
    # 元の画面に戻る
    redirect_to request.referer
  end
    
  def destroy
    # フォロー解除する対象のユーザの取得
    user = User.find(params[:user_id])
    # カレントユーザが対象ユーザをフォロー解除するメソッドを呼び出す
    current_user.unfollow(user)
    # 元の画面に戻る
    redirect_to request.referer
  end
  
end
