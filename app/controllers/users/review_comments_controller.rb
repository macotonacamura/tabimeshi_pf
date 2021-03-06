class Users::ReviewCommentsController < ApplicationController

	def create
		@review = Review.find(params[:review_id])
		@review_comment = current_user.review_comments.new(review_comment_params)
		@review_comment.review_id = @review.id
		if @review_comment.save
		else
			@user = User.find(@review.user_id)
			render 'reviews/show'
		end
	end

	def destroy
		@review = Review.find(params[:review_id])
		ReviewComment.find_by(id:params[:id],review_id:params[:review_id]).destroy
	end

	private
	def review_comment_params
		params.require(:review_comment).permit(:review_comment)
	end

end
