class Genre < ApplicationRecord
	has_many :reviews,dependent: :destroy
	validates :genre_name, presence: true
end
