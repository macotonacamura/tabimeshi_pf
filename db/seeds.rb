# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_user = Admin.where(email: "admin@ex.com")

if admin_user.blank?
    Admin.create!(
    	email: "admin@ex.com",
 	    password: "oooooo"
    )
end


  def country # 共有したい処理
	  connection = Faraday.new(:url => 'https://wft-geo-db.p.rapidapi.com') do |f|
        f.headers["x-rapidapi-host"] = 'wft-geo-db.p.rapidapi.com'
        f.headers["x-rapidapi-key"] = ENV['COUNTRY']
      end

	response = connection.get '/v1/geo/countries'  # GET https://wft-geo-db.p.rapidapi.com 国の情報を取得/固有の処理
	response.body.data.each do |country|
		Country.create(
			name: country['name'],
			code: country['code']
		)
		cities.each do |city|
			City.create(
				code: country['code'],
				name: city['name'],
			)
		end
	end
  end
