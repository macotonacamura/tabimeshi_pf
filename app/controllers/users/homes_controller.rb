class Users::HomesController < ApplicationController

	def top
	end

	def new_guest
		user = User.find_or_create_by( user_name: 'TestUser',email: 'guest@example.com') do |user|
			user.password = SecureRandom.urlsafe_base64
		end
		sign_in user
		redirect_to reviews_path,notice: 'ゲストユーザーとしてログインしました。'
	end

end
