# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    require 'json'

	admin_user = Admin.where(email: "admin@ex.com")

	if admin_user.blank?
	    Admin.create!(
	    	email: "admin@ex.com",
	 	    password: "oooooo"
	    )
	end



#offset = i * 1000
		connection = Faraday.new(:url => 'https://wft-geo-db.p.rapidapi.com') do |f| # 共有したい処理
		f.headers["x-rapidapi-host"] = 'wft-geo-db.p.rapidapi.com'
		f.headers["x-rapidapi-key"] = ENV['COUNTRY']
		end

		#coutries_response = connection.get '/v1/geo/countries?limit=100&offset=0'  # GET https://wft-geo-db.p.rapidapi.com 国の情報を取得/固有の処理
		cities_response = connection.get 'v1/geo/cities?limit=1000&offset=#{offset}'


	    #coutries_res = JSON.parse(coutries_response.body)
	    cities_res = JSON.parse(cities_response.body)

	    #pp coutries_res
	    #pp cities_res

		cities_res["data"].each do |country|
			Country.create!(
				country: country['country'],
				city: country['city'],
				currency: country['currencyCodes']
			)
		end

		#sleep 200
