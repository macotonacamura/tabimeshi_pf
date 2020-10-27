class Admins::UsersController < ApplicationController

  def index
  	@users = User.page(params[:page])
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
  		redirect_to admins_user_path(@user.id)
  	else
  		render 'edit'
  	end
  end

  private
  def user_params
		 params.require(:user).permit(
		 	:user_name,
		 	:introduction,
		 	:email,
		 	:profile_image,
		 	:email,
		 	:is_deleted
		 	)
  end

end
