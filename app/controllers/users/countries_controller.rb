class Users::CountriesController < ApplicationController

	def asia
		@asia = Review.where(country_id: [8])
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
