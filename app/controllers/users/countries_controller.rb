class Users::CountriesController < ApplicationController

	def asia
		#@reviews = Review.all
		#@asia = Country.cities.reviews.where(country: ['China','Korea','Taiwan','Taiwan'])

		@asia = Country.includes(:cities => :reviews).where(country: ['China','Korea','Taiwan'])#Thailand

		@reviews = []
		@asia.each do |country|
			country.cities.each do |city|
				city.reviews.each do |review|
					review
				end
			end
		end

		@user = @reviews.users
		#@asia = Review.includes(:countries => :reviews).where(country: ['China','Korea','Taiwan','Taiwan'])
	end

	def america
	 	@america = Review.where(country: ['United States of America','Canada'])
	end

	def europe
		@europe = Review.where(country:['France','Switzerland','Spain','Italy','United Kingdom'])
	end

	def oseania
		@oseania = Review.where(country: ['Australia','New Zealand'])
	end

end

# SELECT “reviews”.*
# FROM “reviews”
# INNER JOIN “cities” ON “reviews”.“city_id” = “cities”.“id”
# WHERE “cities”.“country_id” =  1

# | r.id | r.review | r.city_id | c.id | c.city | c.country_id |
# |--- | --- | --- | --- | --- | ---- |
# | 1 | ほげ | 1 | 1 | van | 1 |
# | 2 | fuga | 1 | 1 | van | 1 |
# | 3 | fuga | 2 | 2 | van | 2 |
