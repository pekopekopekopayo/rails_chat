class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(create_params.merge(user_id: current_user.id))
    if @chat_room.save
      redirect_to chat_room_path(@chat_room), notice: '채팅방이 생성되었습니다.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
  end

  private

  def create_params
    params.require(:chat_room).permit(:name)
  end
end
