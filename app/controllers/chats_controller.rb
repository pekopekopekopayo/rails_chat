class ChatsController < ApplicationController

    def index
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @chats = Chat.where(chat_room_id: @chat_room.id)
                 .order(created_at: :desc)
                 .page(params[:page])
                 .per(20)

    respond_to do |format|
      format.html
      format.json {
        render json: {
          chats: @chats.map { |chat|
            {
              id: chat.id,
              content: chat.content,
              username: chat.user.name,
              created_at: chat.created_at.strftime('%H:%M'),
              user_id: chat.user_id
            }
          },
          has_more: @chats.next_page.present?,
          current_page: @chats.current_page
        }
      }
    end
  end

  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @chat = @chat_room.chats.build(content: params[:content], user: current_user)

    if @chat.save
      # 소켓으로 실시간 전송
      ActionCable.server.broadcast("chat_room:#{@chat_room.id}", {
        content: @chat.content,
        username: current_user.name,
        user_id: current_user.id,
        timestamp: @chat.created_at.strftime('%H:%M'),
        chat_id: @chat.id
      })

      head :ok
    else
      render json: { errors: @chat.errors }, status: :unprocessable_entity
    end
  end
end
