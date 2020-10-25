class Users::ReviewsController < ApplicationController
  before_action :convert_review_image_format, only: [:create, :update]

  def index
    @reviews = Review.page(params[:page]).reverse_order
  end

  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
  end

  def new
    @review = Review.new
    @review.review_images << Array.new(5, ReviewImage.new)
    @reviewimages = @review.review_images
  end

  def create
    @review = Review.new(@converted_review_params)
    @review.user_id = current_user.id
    if @review.save(review_params)
      redirect_to review_path(@review), notice: "You've created a review successfully."
    else
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(@converted_review_params)
      redirect_to review_path(@review), notice: "You've updateded this review successfully."
    else
      render 'edit'
    end

  end

  def destroy
     @review = Review.find(params[:id])
     @review.destroy
     redirect_to reviews_path
  end


  private

  def convert_review_image_format
    review_images = review_params[:review_images].to_h.values.map do |review_image|
      ReviewImage.new(image: review_image["image"])
    end
    @converted_review_params = review_params
    @converted_review_params['review_images'] = review_images
  end

  def review_params
    params.require(:review).permit(
      :restaurant_name,
      :country,:city,
      :address,
      :budget,
      :rate,
      :muximum_budget,
      :address,
      :latitude,
      :longitude,
      :review,
      review_images: [
        :image
      ]
    )#複数画像upは配列で渡す[]
  end

end
