class Users::UsersController < ApplicationController
 before_action :authenticate_user!
  def index
    @users = User.partical(params[:content]) #.except("GuestUser") #ここで検索結果&削除されていない会員のみ表示 モデルファイルに定義あり
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
       redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user.id)
     flash[:change] = "Updated your infomation."
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

  def likes
    @reviews = current_user.like_list
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


  private
  def user_params
     params.require(:user).permit(:user_name, :introduction, :email, :profile_image)
  end

end