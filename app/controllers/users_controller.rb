class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      cookies.signed[:user_id] = @user.id
      redirect_to root_path, notice: '회원가입이 완료되었습니다.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
