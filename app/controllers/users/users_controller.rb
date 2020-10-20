class Users::UsersController < ApplicationController

  def index
		@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  	   redirect_to user_path(@user.id)
	   flash[:change] = "登録情報を更新しました"
	else
	   render :edit
	end
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  def user_params
		 params.require(:user).permit(:user_name, :introduction, :email, :profile_image)
  end

end
