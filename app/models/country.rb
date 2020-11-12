class Country < ApplicationRecord
	has_many :cities
	has_many :reviews, through: :cities
	belongs_to :continent, optional: true

	validates :country, presence: true
end