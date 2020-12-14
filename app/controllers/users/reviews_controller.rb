class Users::ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
     if params[:country].present? or params[:continent_id].present? #countryもしくはcontinentIDがあるならば、
        country_param = params[:country].present? ? "%#{params[:country]}%" : params[:continent_id] # XXX.present? then(=?) "%部分一致country" else(=:) params[:continent_id]
        where_param = params[:country].present? ? 'countries.country LIKE(?)' : 'countries.continent_id = ?'
        @reviews = Review.joins(city: [:country]).where(where_param, country_param).page(params[:page]).reverse_order #joinsメソッドでreviewsとcities(と、country_id)を内部結合 where(条件) を、降順で並べる
      else
        @reviews = Review.joins(:user).where('users.is_deleted =?', false).page(params[:page]).reverse_order #reviewsとuserを内部結合し、users.is_deletedじゃなかったら 降順で並べる
        @review = @reviews.select{ |review| review.user.is_deleted == false } #?
     end
     # if params[:country].present? #国名の取得
     #    @reviews = Review.joins(city: [:country]).where('countries.country LIKE(?)', "%#{params[:country]}%").page(params[:page]).reverse_order
     # elsif params[:continent_id] .present?
     #    @reviews = Review.joins(city: [:country]).where('countries.continent_id = ?', params[:continent_id]).page(params[:page]).reverse_order
     # else
     #    @reviews = Review.joins(:user).where('users.is_deleted =?', false).page(params[:page]).reverse_order
     #    @review = @reviews.select{ |review| review.user.is_deleted == false }#{}の中の条件に合う投稿を選択
     # end
     @rank = User.create_all_ranks #models/user.rbに定義あり
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

    countries = []
    cities = []
    if params[:keyword].present? #フォームに記述が行われたときにのみ、if以下の処理を行う
      countries = Country.where('country LIKE(?)', "#{params[:keyword]}%") #前方一致
      countries = countries.map(&:country)
      #非同期
      cities = City.where('city LIKE(?)', "#{params[:keyword]}%")
      cities = cities.map(&:city)
    end
  end

  def auto_complete
    countries = Country.select(:country).where("country like '%" + params[:term] + "%'").order(country: :asc).limit(10)
    render json: countries.limit(10).map(&:country).to_json #mapメソッドを使い、countryの配列(10件)を作成し、返す。
  end

  def auto_complete_cities
    cities = City.select(:city).where("city like '%" + params[:term] + "%'").order(city: :asc)
    render json: cities.limit(10).map(&:city).to_json
  end


  # def create
  #   if review_params[:country].blank?
  #      @review = Review.new
  #      render 'new'
  #      return #以後の処理をやらないでね という記述
  #   end

  #   @review = Review.new(review_params.merge({user_id: current_user.id}).except(:country, :city)) #.merge〜でパラメータにuserのidを付け加える
  #   country = Country.find_by(country: review_params[:country])
  #   @review.city = City.find_by(city: review_params[:city],country_id: country.id)
  #   @review = validate_budget(@review)

  #   if @review.save!
  #     sleep(3) #S3 Lambda連携時間確保
  #     redirect_to review_path(@review)
  #     flash[:create] = "You've created a new review successfully."
  #   else
  #     render 'new'
  #   end
  # end

  def create
    if review_params[:country].blank? #もしcountryが空なら
       @review = Review.new
       @review.errors.add(:country, "記述が正しくありません")
       render 'new'
       return #以後の処理ををやらないでね(振り出しに戻る) という記述
    end
    @review = Review.new(review_params.merge({user_id: current_user.id}).except(:country, :city)) #.merge〜でパラメータにuserのidを付け加える
    country = Country.find_by(country: review_params[:country]) #↓country.idのcountryの定義
    @review.city = City.find_by(city: review_params[:city],country_id: country.id) #city確定=countryの確定
    if @review.city.blank?
       @review.errors.add(:city, "記述が正しくありません")
       render 'new'
       return
    end
    if @review.save!
      sleep(3) #S3 Lambda連携時間確保
      redirect_to review_path(@review)
      flash[:create] = "You've created a new review successfully."
    else
      render 'new'
    end
    @review = validate_budget(@review)
  end

  def edit
    @review = Review.find(params[:id])
    # if @review.user == current_user #投稿者本人のみ編集できるようにしたい
    #   render :edit
    # else
    #   redirect_to reviews_path
    # end
    (@review.review_images.count...5).each do |index|
      @review.review_images.build
    end

    countries = Country.where('country LIKE(?)', "#{params[:keyword]}%")
    countries = countries.map(&:country)
    @city = @review.city
  end

  def update
    @review = Review.find(params[:id])
     if review_params[:country].blank? &&
        @review.errors.add(:country, "記述が正しくありません")
        render 'edit'
        return
     end

      country = Country.find_by(country: review_params[:country])
     if country.blank?
        @review.errors.add(:country, "記述が正しくありません")
        render 'edit'
        return
     end
      @review.city = City.find_by(city: review_params[:city],country_id: country.id) #city確定=countryの確定
     if @review.city.blank?
        @review.city = Review.find(params[:id]).city
        @review.errors.add(:city, "記述が正しくありません")
        render 'edit'
        return
     end

      @review = validate_budget(@review)
      if @review.update(review_params.except(:country, :city))
        sleep(3)
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

  def search #インクリメンタルサーチ
   @reviews = Review.joins(city: [:country]).where('countries.country LIKE(?)', "%#{params[:keyword]}%").page(params[:page]) #paramsとして送られてきたkeyword（入力された語句）で、Reviewモデルのcountryカラムを検索し、その結果を@reviewsに代入する。前方一致検索%
    respond_to do |format|
      format.json { render 'index', json: @reviews.map{|review|review.city.country.country}.uniq } #json形式のデータを受け取ったら、@reviewsをデータとして返す そしてindexをrenderで表示する
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :restaurant_name,
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
      :country,
      :city,
      :open,
      :close,
      review_images_attributes: [
        :id,
        :image
      ]
    )#複数画像upは配列で渡す[]
  end

  def validate_budget(review) #saveされる前にここに来る
    review[:budget] = 0 if review[:budget].blank? #デフォルトの値を０にしている for val
    review[:maximum_budget] = 0 if review[:maximum_budget].blank?
    review #返り値 return reviewの略
  end

end