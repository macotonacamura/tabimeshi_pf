class Users::ReviewsController < ApplicationController

  def index
    @reviews = Review.page(params[:page]).reverse_order
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    @review.review_images << Array.new(5, ReviewImage.new)
    @reviewimages = @review.review_images
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to review_path(@review), notice: "You have created a review successfully."
    else
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update

  end

  def destroy
     @review = Review.find(params[:id])
     @review.destroy
     redirect_to reviews_path
  end


  private

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
      review_images_attributes: [
        :image
      ]
    )#複数画像upは配列で渡す[]
  end

end
