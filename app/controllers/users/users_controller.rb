class Users::UsersController < ApplicationController

  def index
	  @users = User.where(is_deleted: false) #ここで削除されていない会員のみ表示
  end

  def show
  	@user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).reverse_order
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

  def following
    @user = User.find(params[:id])
    @users = @user.followings.all
  end

  def follower
    @user = User.find(params[:id])
    @users = @user.followers.all
  end

  def unsubscribe
  	@user = current_user
  end

  def withdraw
  	@user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:withdraw] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
  def user_params
		 params.require(:user).permit(:user_name, :introduction, :email, :profile_image)
  end

end
