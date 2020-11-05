class Users::CountriesController < ApplicationController

	def asia
		@asia = Review.where(country: ['中国','韓国','台湾','タイ','香港'])#.or(country: '台湾').or(country: 'タイ').where(country: '香港')
	end

	def america
		@america = Review.where(country: ['アメリカ','カナダ'])
	end

	def europe
		@europe = Country.where(country: ['フランス','イギリス','スペイン','スペイン'.'イタリア'])
	end

	def oseania
		@oseania = Country.where(country: ['オーストラリア','ニュージーランド'])
	end

end
