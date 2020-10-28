class Admins::ReviewsController < ApplicationController

	def index
	# users = User.where(is_deleted: false)退会すみユーザの投稿は消したい
		@reviews = Review.page(params[:page]).reverse_order
	end

	def show
		@review = Review.find(params[:id])
	end

	def edit
    @review = Review.find(params[:id])
    (@review.review_images.count...5).each do |index|
      @review.review_images.build
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to admins_review_path(@review), notice: "You've updateded this review successfully."
    else
      render 'edit'
    end
  end

  def destroy
     @review = Review.find(params[:id])
     @review.destroy
     redirect_to admins_reviews_path
  end

  def review_params
    params.require(:review).permit(
      :restaurant_name,
      :country,:city,
      :address,
      :budget,
      :rate,
      :maximum_budget,
      :address,
      :genre_id,
      :latitude,
      :longitude,
      :review,
      review_images_attributes: [
      :image
      ]
    )#複数画像upは配列で渡す[]
  end



end
