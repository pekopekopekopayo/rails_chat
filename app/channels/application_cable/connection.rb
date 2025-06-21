module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # 일단 인증을 단순화하여 연결 자체는 허용
    def connect
      # 연결 로그
      logger.add_tags 'ActionCable', 'Connection'
    end
  end
end
