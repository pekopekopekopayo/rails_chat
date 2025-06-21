class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to new_session_path, alert: '로그인이 필요합니다.' if current_user.nil?
  end

  def current_user_token
    Rails.application.message_verifier('user_token').generate(current_user.id) if current_user
  end

  helper_method :current_user, :current_user_token
end
