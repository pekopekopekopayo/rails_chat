class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room:#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
