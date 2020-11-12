class Genre < ApplicationRecord
	has_many :reviews,dependent: :destroy
	#validates :genre, presence: true
end
