class SessionsController < ApplicationController
  def sign_in
    @user = User.find_by(email: params[:email])
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: '로그인되었습니다.'
    else
      render :sign_in, status: :unprocessable_entity
    end
  end
end
