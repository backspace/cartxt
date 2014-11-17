class UsersController < ApplicationController
  before_filter :require_admin

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:approved)
  end
end
