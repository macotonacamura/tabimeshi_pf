module Country
  extend ActiveSupport::Concern

  def country # 共有したい処理
	  connection = Faraday.new(:url => 'https://wft-geo-db.p.rapidapi.com') do |f|
        f.headers["x-rapidapi-host"] = 'wft-geo-db.p.rapidapi.com'
        f.headers["x-rapidapi-key"] = ENV['COUNTRY']
      end
	response = connection.get '/v1/geo/countries'  # GET https://wft-geo-db.p.rapidapi.com 国の情報を取得/固有の処理
	response.body

  end


end


