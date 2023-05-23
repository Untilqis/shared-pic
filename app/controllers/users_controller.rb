class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
    @albums = @user.albums
  end

  def edit
    unless current_user == @user
      redirect_to root_path
    end
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
