class UsersController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    @user.update(params.require(:user).permit(:name, :email, :password))
    if @user.update(params.require(:user).permit(:name, :email, :password))
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end
  
end
