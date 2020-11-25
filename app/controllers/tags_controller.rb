class TagsController < ApplicationController

  # タグ検索
  def search
    # クリックしたタグを取得
    @tag = Tag.find(params[:id])
    # クリックしたタグに紐付けられた投稿を全て表示
    @magics = @tag.magics.all.page(params[:page]).per(8)
  end

end
