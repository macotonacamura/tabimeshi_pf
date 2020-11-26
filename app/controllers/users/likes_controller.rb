class Users::LikesController < ApplicationController
	before_action :review_params

	def create
		@review = Review.find(params[:review_id])
		like = current_user.likes.new(review_id: @review.id)
		like.save
	end

	def destroy
		@review = Review.find(params[:review_id])
		like = current_user.likes.find_by(review_id: @review.id)
		like.destroy
	end

	private
	def review_params
		@review = Review.find(params[:review_id])
	end
end
