class RoomsController < ApplicationController

  before_action :authenticate_user!

  # DMユーザー一覧画面の表示
  def index
    @user = current_user
    # 自分のIDが所属するentryを取得
    @currentEntries = current_user.entries
    myroomIds = []

    # 取得したentry内のconnect.idをmyConnectIdsに格納する。
    @currentEntries.each do |entry|
      myroomIds << entry.room.id
    end
    # myConnectIdsの中から、自分のID以外のID(すなわち相手のID)のEntryを取得する。
    @anotherEntries = Entry.where(room_id: myroomIds).where('user_id != ?',@user.id).includes(:room)
  end

  # ルームを新規に作成する
  def create
    @room = Room.create
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  # 作成済みのルームを参照する
  def show
  @room = Room.find(params[:id])
    # アクセス時にルームが存在している場合
    if Entry.where(:user_id => current_user.id, :room_id => @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_to request.referer
    end
  end
end