class UsersController < ApplicationController
  before_action :move_to_top

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
  end

  private

  def move_to_top
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end
end
