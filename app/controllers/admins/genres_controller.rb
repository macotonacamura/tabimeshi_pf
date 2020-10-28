class Admins::GenresController < ApplicationController

  def index
		@genre = Genre.new
		@genres = Genre.all.page(params[:page]).per(6)

	end

	def create
		@genre = Genre.new(genre_params)
		if @genre.save
			redirect_to admins_genres_path, notice: "Genre has successfully created!"
		else
			@genres = Genre.all
			render :index
		end
	end

	def edit
		@genre = Genre.find(params[:id])

	end

	def update
		@genre = Genre.find(params[:id])
		@genres = Genre.all
			if @genre.update(genre_params)
				flash[:genre] = "商品ジャンルを変更しました"
				redirect_to admins_genres_path
			else
				render :edit
			end
	end



	private
	def genre_params
		params.require(:genre).permit(:genre_name, :is_active)
	end

end
