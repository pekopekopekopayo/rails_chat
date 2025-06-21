class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room:#{params[:room_id]}"

    # 입장 메시지 (선택사항)
    ActionCable.server.broadcast("chat_room:#{params[:room_id]}", {
      type: 'system',
      content: "#{current_user.name}님이 입장했습니다.",
      username: 'System',
      timestamp: Time.current.strftime('%H:%M')
    })
  end

  def unsubscribed
    # 퇴장 메시지 (선택사항)
    ActionCable.server.broadcast("chat_room:#{params[:room_id]}", {
      type: 'system',
      content: "#{current_user.name}님이 퇴장했습니다.",
      username: 'System',
      timestamp: Time.current.strftime('%H:%M')
    })
  end
end
