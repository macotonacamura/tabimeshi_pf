class Users::RelationshipsController < ApplicationController
	before_action :set_user

	def create
		following = current_user.follow(@user)
		if following.save
			flash[:success] = 'Followed'
			#redirect_to request.referer
		else
			flash.now[:alert] = 'failed to follow user'
			#redirect_to request.referer
		end
	end


	def destroy
		following = current_user.unfollow(@user)
		if following.destroy
			flash[:success] = 'Unfollowed user'
			#redirect_to request.referer
		else
			flash.now[:alert] = 'failed to unfollow user'
			#redirect_to request.referer
		end
	end


	private

	def set_user
		@user = User.find(params[:follow_id])
	end

end
