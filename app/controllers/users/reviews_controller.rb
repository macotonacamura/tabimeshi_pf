class Users::ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    #@review.revew_images.build #親モデルに属する子モデルのインスタンスを新たに生成したい場合に使うメソッド
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
  end


  private

  def review_params
     params.require(:review).permit(:restaurant_name, :country,:city,:address,:budget,:muximum_budget,:address,:review, [review_images_attributes: [:revew_images]])#複数画像upは配列で渡す[]
  end

end
