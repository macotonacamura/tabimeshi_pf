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

# Country
if Country.exists?(country: 'Japan') == false
	connection = Faraday.new(:url => 'https://wft-geo-db.p.rapidapi.com') do |f| # 共有したい処理
		f.headers["x-rapidapi-host"] = 'wft-geo-db.p.rapidapi.com'
		f.headers["x-rapidapi-key"] = ENV['COUNTRY']
	end

	coutries_response = connection.get '/v1/geo/countries?limit=200'  # GET https://wft-geo-db.p.rapidapi.com 国の情報を取得/固有の処理
	coutries_res = JSON.parse(coutries_response.body)

	coutries_res["data"].each do |country|
		Country.create!(
			country: country['name'],
			currency: country['currencyCodes']
		)
	end
end

# City
if City.exists?(city: 'Tokyo') == false
	MAX = 273691
	(MAX / 1000 + 1).times do |i|
		offset = 1000 * i
		city_connection = Faraday.new(:url => 'https://wft-geo-db.p.rapidapi.com') do |f| # 共有したい処理
			f.headers["x-rapidapi-host"] = 'wft-geo-db.p.rapidapi.com'
			f.headers["x-rapidapi-key"] = ENV['COUNTRY']
		end
		cities_response = city_connection.get "v1/geo/cities?limit=1000&offset=#{offset}"
		cities_res = JSON.parse(cities_response.body)
		cities_res["data"].each do |c|
			country = Country.where(country: c['country'])[0]
			unless country.blank?
				City.create(
					city: c['city'],
					country_id: country.id
				)
			end
		end
	    sleep 0.2 #serverの負担軽減
	end
end


# 大陸名登録するクエリ
if Continent.exists?(name: 'asia') == false
	p "asia登録開始"
	continent_asia = Continent.create(name:"asia")
	asia = ['Japan', 'Taiwan', 'China', 'Thailand']

	asia.each do |country_name|
		country = Country.find_by(country: country_name)
		next if country.nil?
		country.update(continent_id: continent_asia.id)
	end
	p "asia登録完了"
else
	p "asia登録済み"
end

if Continent.exists?(name: 'america') == false
	p "america登録開始"
	continent_america = Continent.create(name:"america")
	america = ['United States of America','Canada']

	america.each do |country_name|
		country = Country.find_by(country: country_name)
		next if country.nil?
		country.update(continent_id: continent_america.id)
	end
	p "america登録完了"
else
	p "america登録済み"
end


if Continent.exists?(name: 'europe') == false
	p "europe登録開始"
	continent_europe = Continent.create(name:"europe")
	europe = ['France','Switzerland','Spain','Italy','United Kingdom']

	europe.each do |country_name|
		country = Country.find_by(country: country_name)
		next if country.nil?
		country.update(continent_id: continent_europe.id)
	end
	p "europe登録完了"
else
	p "europe登録済み"
end



if Continent.exists?(name: 'oceania') == false
	p "oceania登録開始"
	continent_oceania = Continent.create(name:"oceania")
	oceania = ['Australia','New Zealand']

	oceania.each do |country_name|
		country = Country.find_by(country: country_name)
		next if country.nil?
		country.update(continent_id: continent_oceania.id)
	end
	p "oceania登録完了"
else
	p "oceania登録済み"
end




