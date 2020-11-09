class Country < ApplicationRecord
	has_many :cities
	has_many :reviews, through: :cities
	belongs_to :continent

	validates :country, presence: true
end