module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      # signed token으로 안전하게 인증
      if token = request.params[:token]
        begin
          user_id = Rails.application.message_verifier('user_token').verify(token)
          User.find_by(id: user_id)
        rescue ActiveSupport::MessageVerifier::InvalidSignature
          reject_unauthorized_connection
        end
      else
        reject_unauthorized_connection
      end
    end
  end
end
