class MessagesController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])

    message_data = {
      content: params[:content],
      username: current_user.name,
      user_id: current_user.id,
      timestamp: Time.current.strftime('%H:%M'),
      room_id: @chat_room.id
    }

    # Action Cable로 실시간 브로드캐스트
    ActionCable.server.broadcast("chat_room_#{@chat_room.id}", message_data)

    head :ok
  end
end
