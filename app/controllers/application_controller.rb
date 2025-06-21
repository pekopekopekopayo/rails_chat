class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :current_user

  private

  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def authenticate_user!
    redirect_to new_session_path, alert: '로그인이 필요합니다.' if current_user.nil?
  end
end
