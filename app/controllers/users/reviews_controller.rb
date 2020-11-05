class Users::ReviewsController < ApplicationController
 before_action :authenticate_user!
  def index
       if params[:country].present? #国名の取得
         @reviews = Review.where('country LIKE(?)', "%#{params[:country]}%").page(params[:page])
       else
          @reviews = Review.page(params[:page]).reverse_order
          #flash[:failure] = "該当するページが見つかりませんでした。" #表示がうまくいかない
       end

       #@all_ranks = Review.find(Review.group(:review_id).order('count(review_id) desc').limit(2).pluck(:review_id))
    #@reviews = Review.page(params[:page]).reverse_order
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

    # @review.build_country

    # #countries = Country.all もともと全件出すようにしてた
    # countries = Country.where('country LIKE(?)', "#{params[:keyword]}%")これで検索絞れるのでは？
    # countries = countries.map(&:country)
    # respond_to do |format|
    # format.html
    # format.json { render json: countries.to_json }
    # end
  end

  # def auto_complete
  #   countries = Country.select(:name).where("name like '%" + params[:term] + "%'").order(:name)
  #   countries = countries.map(&:name)
  #   render json: countries.to_json
  #   end


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
    @reviews = Review.where('country LIKE(?)', "#{params[:keyword]}%") #paramsとして送られてきたkeyword（入力された語句）で、Reviewモデルのcountryカラムを検索し、その結果を@reviewsに代入する。前方一致検索%
    respond_to do |format|
      format.json { render 'index', json: @reviews.map{|review|review.country}.uniq } #json形式のデータを受け取ったら、@reviewsをデータとして返す そしてindexをrenderで表示する
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
      :currency,
      countries_attributes: [:country,:city],
      review_images_attributes: [
        :id,
        :image
      ]
    )#複数画像upは配列で渡す[]
  end

end
