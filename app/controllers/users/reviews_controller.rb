class Users::ReviewsController < ApplicationController
  include Country #concernファイルのcountry.rbのCountyメソッドを呼び出し
  def index
    # モーダルで入力した国名を params[:xxx] みたいな感じで取得する
    # params[:xxx] の中には Canada みたいな国名が入ってます
    # @reviews =
    #   if params[:xxx]
    #     Review.where('country LIKE(?)', "%#{params[:xxx]}%")
    #   else
    #     Review.all
    #   end
    # @reviews = @reviews.page(params[:page]).reverse_order
    @reviews = Review.page(params[:page]).reverse_order
    # users = User.where(is_deleted: false)退会すみユーザの投稿は消したい
  end

  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
  end

  def new
    @review = Review.new
    (@review.review_images.count...5).each do |index|
      @review.review_images.build
    end
  end

  def create
    @review = Review.new(review_params.merge({user_id: current_user.id})) #.merge〜でパラメータにuserのidを付け加える
    if @review.save
      redirect_to review_path(@review)
      flash[:create] = "You've created a new review successfully."
    else
      render 'new'
    end
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
      redirect_to review_path(@review)
      flash[:update] = "You've updateded this review successfully."
    else
      render 'edit'
    end
  end

  def destroy
     @review = Review.find(params[:id])
     @review.destroy
     redirect_to reviews_path
  end

  def search
  @reviews = Review.where('country LIKE(?)', "%#{params[:keyword]}%") #paramsとして送られてきたkeyword（入力された語句）で、Userモデルのnameカラムを検索し、その結果を@usersに代入する
    respond_to do |format|
      format.json { render 'index', json: @reviews } #json形式のデータを受け取ったら、@usersをデータとして返す そしてindexをrenderで表示する
    end
  end


  private

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
        :id,
        :image
      ]
    )#複数画像upは配列で渡す[]
  end

end
