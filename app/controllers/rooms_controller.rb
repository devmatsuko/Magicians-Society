class RoomsController < ApplicationController

  before_action :authenticate_user!

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