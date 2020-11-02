class Users::RelationshipsController < ApplicationController
	before_action :set_user

	def create
		following = current_user.follow(@user)
		if following.save
			flash[:success] = 'Followed'
		else
			flash.now[:alert] = 'failed to follow user'
		end
	end


	def destroy
		following = current_user.unfollow(@user)
		if following.destroy
			flash[:success] = 'Unfollowed user'
		else
			flash.now[:alert] = 'failed to unfollow user'
		end
	end


	private

	def set_user
		@user = User.find(params[:follow_id])
	end

end
